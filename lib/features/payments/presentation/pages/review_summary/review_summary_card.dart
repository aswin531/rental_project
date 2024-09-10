import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:rentit/features/payments/presentation/pages/review_summary/car_info_section.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_bloc.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_event.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_state.dart';
import 'package:rentit/utils/appcolors.dart';
import 'package:rentit/utils/primary_text.dart';

class ReviewSummaryScreen extends StatelessWidget {
  const ReviewSummaryScreen({super.key});

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
                const PrimaryText(
                  text: "You didn't request any rental",
                  size: 18,
                  color: Colors.black54,
                ),
              ],
            ),
          );
        }
        final rentalRequestWithCarDetails = state.requestsWithCarDetails.last;
        return Scaffold(
          backgroundColor: ExternalAppColors.bg,
          appBar: AppBar(
            backgroundColor: ExternalAppColors.bg,
            //leading: const BackButton(),
            title: const Text('Review Summary'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarInfoSection(
                  rentalPrice: rentalRequestWithCarDetails
                      .car.rentalPriceRange.start
                      .toString(),
                  body: rentalRequestWithCarDetails.car.body,
                  brand: rentalRequestWithCarDetails.car.make,
                  imageUrl: rentalRequestWithCarDetails.car.imageUrls.last,
                  model: rentalRequestWithCarDetails.car.model,
                ),
                const SizedBox(height: 20),
                const DateTimeSection(),
                const SizedBox(height: 20),
                const PricingSection(),
                const SizedBox(height: 20),
                const PaymentMethodSection(),
                const Spacer(),
                const SizedBox(height: 20),
                const ContinueButton(),
              ],
            ),
          ),
        );
      } else if (state is RentalRequestError) {
        return Center(child: Text('Error: ${state.message}'));
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
