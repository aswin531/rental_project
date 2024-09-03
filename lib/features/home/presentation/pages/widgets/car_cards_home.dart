import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rentit/features/home/domain/entity/car_entity.dart';
import 'package:rentit/features/home/presentation/bloc/selectedcar/selected_bloc.dart';
import 'package:rentit/features/home/presentation/bloc/selectedcar/selectedcar_event.dart';
import 'package:rentit/utils/appcolors.dart';
import 'package:rentit/widgets/custom_container.dart';

class CarCard extends StatelessWidget {
  final CarVehicleEntity car;

  const CarCard({
    super.key,
    required this.car,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<SelectedCarBloc>().add(SelectCar(car));
        context.push('/carDetailPage');
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: ExternalAppColors.bg,
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          car.imageUrls.last,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 15,
                    left: 15,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow, size: 16),
                          SizedBox(width: 4),
                          Text(
                            '4.9',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 15,
                    right: 15,
                    child: IconButton(
                      icon: const Icon(Icons.favorite_border,
                          color: Colors.black),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomContainer(text: car.body),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(car.make,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18)),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              '\$${car.rentalPriceRange.start.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: ExternalAppColors.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: '/day',
                          style: TextStyle(
                              color: ExternalAppColors.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(
                color: ExternalAppColors.bg,
                thickness: 1,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const SizedBox(width: 20),
                  const Icon(
                    Icons.local_gas_station,
                    size: 16,
                    color: Colors.blue,
                  ),
                  Text(car.engine),
                  const SizedBox(width: 90),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.person,
                    size: 16,
                    color: Colors.blue,
                  ),
                  Text('${car.seatCapacity} Seats'),
                  const SizedBox(width: 90),
                  const Icon(
                    Icons.adjust_outlined,
                    size: 16,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 8),
                  const Text('Manual', style: TextStyle(color: Colors.black)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
