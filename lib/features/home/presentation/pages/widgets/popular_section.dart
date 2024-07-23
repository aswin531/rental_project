
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/home/domain/entity/car_entity.dart';
import 'package:rentit/features/home/presentation/bloc/car/carbloc.dart';
import 'package:rentit/features/home/presentation/bloc/car/carevent.dart';
import 'package:rentit/features/home/presentation/pages/carlistscreen.dart';

class PopularCarSection extends StatelessWidget {
  final List<CarVehicleEntity> cars;

  const PopularCarSection({super.key, required this.cars});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Popular Car',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            TextButton(
              onPressed: () => context.read<CarBloc>().add(FetchCars()),
              child:
                  const Text('View All', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: cars.length,
          itemBuilder: (context, index) {
            final car = cars[index];
            return CarCard(
              rating: 4.9, // Hardcoded rating
              imageUrl: car.imageUrls.last,
              carType: car.model,
              carName: '${car.make} ${car.model}',
              pricePerHour: car.rentalPriceRange,
              fuelType: car.engine,
              seats: car.seatCapacity,
              transmission: 'Manual', // Hardcoded transmission
            );
          },
        ),
      ],
    );
  }
}