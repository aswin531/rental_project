import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_bloc.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_event.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_state.dart';
import 'package:rentit/features/rental/presentation/pages/mybooking/widgets/booking_button.dart';
import 'package:rentit/features/rental/presentation/pages/mybooking/widgets/car_specs.dart';
import 'package:rentit/features/rental/presentation/pages/mybooking/widgets/req_car_details.dart';
import 'package:rentit/utils/appcolors.dart';

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
          final rentalRequestWithCarDetails =
              state.requestsWithCarDetails.last;

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
                    imageUrl: rentalRequestWithCarDetails.car.imageUrls.last,
                    model: rentalRequestWithCarDetails.car.model,
                    rentalPrice: rentalRequestWithCarDetails
                        .car.rentalPriceRange.start
                        .toString(),
                  ),
                  const SizedBox(height: 20),
                  CarSpecs(
                    transimission: "Manual",
                    engine: rentalRequestWithCarDetails.car.engine,
                    seatCapacity: rentalRequestWithCarDetails.car.seatCapacity,
                  ),
                  const SizedBox(height: 20),
                 // const LocationMap(),
                  const SizedBox(height: 20),
                  ActionButtons(
                    rentalPrice: rentalRequestWithCarDetails
                        .car.rentalPriceRange.start
                        .toString(),
                  ),
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
