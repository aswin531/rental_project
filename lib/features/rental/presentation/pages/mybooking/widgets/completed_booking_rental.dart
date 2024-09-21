import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:rentit/core/injection_container/dependency_injection.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_bloc.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_state.dart';
import 'package:rentit/features/rental/presentation/pages/mybooking/widgets/car_specs.dart';
import 'package:rentit/features/rental/presentation/pages/mybooking/widgets/req_car_details.dart';
import 'package:rentit/utils/appcolors.dart';

class CompletedBookingsContent extends StatelessWidget {
  const CompletedBookingsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RentalRequestBloc, RentalRequestState>(
      builder: (context, state) {
        if (state is RentalRequestInitial) {
          final user = firebaseAuthInstance.currentUser!.uid;
          //context.read<RentalRequestBloc>().add(FetchCompletedRentalRequestsEvent(user));
        }
        if (state is UserRentalRequestsWithCarDetailsLoaded) {
          if (state.requestsWithCarDetails.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/animation/no_user.json',
                    width: 250,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "No completed rental requests",
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                ],
              ),
            );
          }
          final rentalRequestWithCarDetails = state.requestsWithCarDetails.first;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                  color: ExternalAppColors.white,
                  borderRadius: BorderRadius.circular(15)),
              child: ListView(
                children: [
                  CarDetails(
                    body: rentalRequestWithCarDetails.car.body,
                    brand: rentalRequestWithCarDetails.car.make,
                    imageUrl: rentalRequestWithCarDetails.car.imageUrls.first,
                    model: rentalRequestWithCarDetails.car.model,
                    rentalPrice: rentalRequestWithCarDetails
                        .rentalRequest.estimatedCost
                        .toString(),
                    status: rentalRequestWithCarDetails.rentalRequest.status
                        .toString()
                        .split('.')
                        .last
                        .toUpperCase(),
                  ),
                  const SizedBox(height: 20),
                  CarSpecs(
                    transimission: "Manual",
                    engine: rentalRequestWithCarDetails.car.engine,
                    seatCapacity: rentalRequestWithCarDetails.car.seatCapacity,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Payment Status: ${rentalRequestWithCarDetails.rentalRequest.paymentStatus}',
                    style: TextStyle(
                      fontSize: 16,
                      color: ExternalAppColors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // ActionButtons and more can go here
                ],
              ),
            ),
          );
        } else if (state is RentalRequestError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
