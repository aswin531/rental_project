import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rentit/features/home/presentation/bloc/selectedcar/selected_bloc.dart';
import 'package:rentit/features/home/presentation/bloc/selectedcar/selectedcar_state.dart';
import 'package:rentit/features/payments/presentation/pages/review_summary/car_info_section.dart';
import 'package:rentit/features/rental/domain/entity/rental_entity.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_bloc.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_event.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_state.dart';
import 'package:rentit/utils/appcolors.dart';
import 'package:rentit/utils/primary_text.dart';

class RentalRequestReviewSummaryScreen extends StatelessWidget {
  final String carId;
  final DateTime pickupDate;
  final DateTime pickUpTime;
  final DateTime returnDate;
  final DateTime returnTime;
  final String pickupLocation;
  final String dropOffLocation;
  final String userId;
  final String name;
  final String phone;
  final String email;
  final String address;
  final String licenseNumber;
  final String comments;
  final double estimatedKilometersDriven;

  const RentalRequestReviewSummaryScreen({
    super.key,
    required this.carId,
    required this.pickupDate,
    required this.returnDate,
    required this.pickupLocation,
    required this.dropOffLocation,
    required this.userId,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.licenseNumber,
    required this.comments,
    required this.pickUpTime,
    required this.returnTime,
    required this.estimatedKilometersDriven,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<RentalRequestBloc, RentalRequestState>(
      listener: (context, state) {
        if (state is RentalRequestCreated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Rental request submitted successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
        } else if (state is RentalRequestError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${state.message}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: ExternalAppColors.bg,
        appBar: AppBar(
          backgroundColor: ExternalAppColors.bg,
          title: const Text('Rental Summary',
              style: TextStyle(color: Colors.black)),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<SelectedCarBloc, SelectedCarState>(
              builder: (context, state) {
                if (state is CarSelected) {
                  final selectedCar = state.car;
                  debugPrint(selectedCar.toString());
                  final rentalDays =
                      returnDate.difference(pickupDate).inDays + 1;
                  const double defaultFreeKmAllowance = 100;
                  const double defaultPerKmRate = 0.5;
                  final pricePerDay = selectedCar.rentalPriceRange.end.toInt();

                  final extraKm =
                      (estimatedKilometersDriven > defaultFreeKmAllowance)
                          ? estimatedKilometersDriven - defaultFreeKmAllowance
                          : 0;
                  final estimatedCost =
                      (pricePerDay * rentalDays) + (extraKm * defaultPerKmRate);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CarInfoSection(
                        rentalPrice: pricePerDay.toString(),
                        body: selectedCar.body,
                        brand: selectedCar.make,
                        imageUrl: selectedCar.imageUrls.first,
                        model: selectedCar.model,
                      ),
                      const SizedBox(height: 24),
                      _buildSectionTitle('Rental Details'),
                      _buildDetailRow('Pick-up Date',
                          DateFormat('MMM dd, yyyy').format(pickupDate)),
                      _buildDetailRow('Pick-up Time',
                          DateFormat('hh:mm a').format(pickUpTime)),
                      _buildDetailRow('Return Date',
                          DateFormat('MMM dd, yyyy').format(returnDate)),
                      _buildDetailRow('Return Time',
                          DateFormat('hh:mm a').format(returnTime)),
                      _buildDetailRow('Pick-up Location', pickupLocation),
                      _buildDetailRow('Drop-off Location', dropOffLocation),
                      const SizedBox(height: 24),
                      const Divider(),
                      _buildSectionTitle('Pricing'),
                      _buildDetailRow(
                          'Daily Rate', '\$${pricePerDay.toStringAsFixed(2)}'),
                      _buildDetailRow('Number of Days', rentalDays.toString()),
                      _buildDetailRow('Estimated Kilometers',
                          '${estimatedKilometersDriven.toStringAsFixed(2)} km'),
                      _buildDetailRow('Free Kilometer Allowance',
                          '${defaultFreeKmAllowance.toStringAsFixed(2)} km'),
                      _buildDetailRow('Extra Kilometer Rate',
                          '\$${defaultPerKmRate.toStringAsFixed(2)}/km'),
                      _buildDetailRow('Estimated Total Cost',
                          '\$${estimatedCost.toStringAsFixed(2)}',
                          isTotal: true),
                      const SizedBox(height: 24),
                      const Divider(),
                      _buildSectionTitle('Customer Information'),
                      _buildDetailRow('Name', name),
                      _buildDetailRow('Phone', phone),
                      _buildDetailRow('Email', email),
                      _buildDetailRow('Address', address),
                      _buildDetailRow('License Number', licenseNumber),
                      if (comments.isNotEmpty)
                        _buildDetailRow('Comments', comments),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child:
                            BlocBuilder<RentalRequestBloc, RentalRequestState>(
                          builder: (context, state) {
                            return ElevatedButton(
                              onPressed: state is RentalRequestLoading
                                  ? null
                                  : () =>
                                      _submitRequest(context, estimatedCost),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ExternalAppColors.blue,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: PrimaryText(
                                text: state is RentalRequestLoading
                                    ? 'Submitting...'
                                    : 'Confirm and Submit',
                                size: 18,
                                color: ExternalAppColors.white,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  void _submitRequest(BuildContext context, double estimatedCost) {
    final rentalRequest = RentalRequest(
      id: licenseNumber,
      carId: carId,
      userId: userId,
      pickUpLocation: pickupLocation,
      dropOffLocation: dropOffLocation,
      pickupDate: pickupDate,
      returnDate: returnDate,
      pickupTime: pickUpTime,
      returnTime: returnTime,
      name: name,
      phone: phone,
      email: email,
      address: address,
      licenseNumber: licenseNumber,
      comments: comments,
      createdAt: DateTime.now(),
      status: RentalRequestStatus.pending,
      estimatedCost: estimatedCost,
    );

    context
        .read<RentalRequestBloc>()
        .add(CreateRentalRequestEvent(rentalRequest));
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[600])),
          Text(
            value,
            style: isTotal
                ? const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
                : null,
          ),
        ],
      ),
    );
  }
}
