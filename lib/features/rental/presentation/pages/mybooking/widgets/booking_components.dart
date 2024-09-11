import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
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
    return BlocBuilder<RentalRequestBloc, RentalRequestState>(
      builder: (context, state) {
        if (state is RentalRequestInitial) {
          final user = FirebaseAuth.instance.currentUser!.uid;
          context
              .read<RentalRequestBloc>()
              .add(FetchUserRentalRequestsWithCarDetailsEvent(user));
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
                    "You didn't request any rental",
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                ],
              ),
            );
          }
          final rentalRequestWithCarDetails =
              state.requestsWithCarDetails.first;
          debugPrint(rentalRequestWithCarDetails.rentalRequest.toString());
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                  color: ExternalAppColors.white,
                  borderRadius: BorderRadius.circular(15)),
              child: ListView(
                //crossAxisAlignment: CrossAxisAlignment.start,
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
                  // PrimaryText(
                  //   text: rentalRequestWithCarDetails.rentalRequest.userId,
                  //   color: ExternalAppColors.black,
                  // ),
                  // const SizedBox(height: 20),
                  // PrimaryText(
                  //   text: rentalRequestWithCarDetails.rentalRequest.carId,
                  //   color: ExternalAppColors.black,
                  // ),
                  // const SizedBox(height: 20),
                  PrimaryText(
                    text:
                        rentalRequestWithCarDetails.rentalRequest.paymentStatus,
                    color: ExternalAppColors.black,
                  ),
                  // const LocationMap(),
                  const SizedBox(height: 20),
                  ActionButtons(
                    documentId:
                        rentalRequestWithCarDetails.rentalRequest.id.toString(),
                    rentalPrice: rentalRequestWithCarDetails
                        .rentalRequest.estimatedCost
                        .toString(),
                  ),
                  // AnimatedStatus(
                  //   isVisible: true,
                  //   status: rentalRequestWithCarDetails.rentalRequest.status
                  //       .toString(),
                  // )
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
