import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:rentit/core/injection_container/dependency_injection.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_bloc.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_event.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_state.dart';
import 'package:rentit/features/rental/presentation/pages/mybooking/widgets/booking_button.dart';
import 'package:rentit/features/rental/presentation/pages/mybooking/widgets/car_specs.dart';
import 'package:rentit/features/rental/presentation/pages/mybooking/widgets/req_car_details.dart';
import 'package:rentit/utils/appcolors.dart';
import 'package:rentit/utils/primary_text.dart';

class BookingContent extends StatelessWidget {
  const BookingContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RentalRequestBloc, RentalRequestState>(
      listener: (context, state) {
        if (state is RentalRequestError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.message}')),
          );
        }
      },
      builder: (context, state) {
        if (state is RentalRequestInitial) {
          final user = firebaseAuthInstance.currentUser!.uid;
          context
              .read<RentalRequestBloc>()
              .add(FetchUserRentalRequestsWithCarDetailsEvent(user));
        }
        if (state is RentalRequestLoading) {
          return Center(
            child: Lottie.asset('assets/animation/loading.json',
                fit: BoxFit.cover, height: 100),
          );
        }

        if (state is UserRentalRequestsWithCarDetailsLoaded) {
          debugPrint('Received rental requests: ${state.requestsWithCarDetails.length}');
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
                    "You didn't request any rental",
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                ],
              ),
            );
          }
          final rentalRequestWithCarDetails =
              state.requestsWithCarDetails.first;
          debugPrint(rentalRequestWithCarDetails.car.toString());
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

                  PrimaryText(
                      text:
                          "Payment status: ${rentalRequestWithCarDetails.rentalRequest.carId.toUpperCase()}",
                      color: ExternalAppColors.blue,
                      size: 20),
                  // const LocationMap(),
                  const SizedBox(height: 20),
                  ActionButtons(
                    documentId:
                        rentalRequestWithCarDetails.rentalRequest.id.toString(),
                    rentalPrice: rentalRequestWithCarDetails
                        .rentalRequest.estimatedCost
                        .toString(),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(
              child: Lottie.asset('assets/animation/loading.json',
                  fit: BoxFit.cover, height: 100));

          //return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
