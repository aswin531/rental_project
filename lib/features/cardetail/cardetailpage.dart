import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/rental/domain/entity/rental_entity.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_event.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_state.dart';

class CarDetailPage extends StatelessWidget {
  final String carName;
  final String carType;
  final String imageUrl;
  final double rating;
  final RangeValues pricePerHour;
  final String fuelType;
  final int seats;
  final String transmission;

  const CarDetailPage({
    super.key,
    required this.carName,
    required this.carType,
    required this.imageUrl,
    required this.rating,
    required this.pricePerHour,
    required this.fuelType,
    required this.seats,
    required this.transmission,
  });

  @override
  Widget build(BuildContext context) {
    DateTime? startDate;
    DateTime? endDate;

    Future<void> selectDate(BuildContext context, bool isStartDate) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101),
      );
      if (picked != null) {
        if (isStartDate) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.share), onPressed: () {}),
          IconButton(icon: const Icon(Icons.favorite_border), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                height: 300,
                child: Image.network(imageUrl, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(carType,
                      style: const TextStyle(fontSize: 18, color: Colors.grey)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(carName,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber),
                          Text(rating.toString(),
                              style: const TextStyle(fontSize: 18)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildTabButton('About', isSelected: true),
                      _buildTabButton('Gallery'),
                      _buildTabButton('Review'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text('Specifications',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  _buildSpecItem(
                      Icons.local_gas_station, 'Fuel Type', fuelType),
                  _buildSpecItem(Icons.person, 'Seats', '$seats'),
                  _buildSpecItem(Icons.settings, 'Transmission', transmission),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          'Price: \$${pricePerHour.start.toStringAsFixed(2)}/hr',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () => selectDate(context, true),
                            child: const Text('Select Start Date'),
                          ),
                          ElevatedButton(
                            onPressed: () => selectDate(context, false),
                            child: const Text('Select End Date'),
                          ),
                        ],
                      ),
                      BlocConsumer<RentalRequestBloc, RentalRequestState>(
                        listener: (context, state) {
                          if (state is RentalRequestCreated) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Rental request created successfully!'),
                              ),
                            );
                          } else if (state is RentalRequestError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error: ${state.message}'),
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: state is RentalRequestLoading
                                ? null
                                : () {
                                    if (startDate != null && endDate != null) {
                                      final request = RentalRequest(
                                        carId: carName,
                                        userId: 'user_id', endDate:endDate! , startDate: startDate!,
                                      );
                                      context.read<RentalRequestBloc>().add(
                                            CreateRentalRequestEvent(request),
                                          );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Please select both start and end dates.'),
                                        ),
                                      );
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue),
                            child: state is RentalRequestLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text('Book Now'),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String text, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(color: isSelected ? Colors.white : Colors.black),
      ),
    );
  }

  Widget _buildSpecItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 24),
          const SizedBox(width: 8),
          Text('$label: $value'),
        ],
      ),
    );
  }
}
