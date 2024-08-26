import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/core/testwidgets/review_summary/car_info_section.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_bloc.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_event.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_state.dart';
import 'package:rentit/utils/appcolors.dart';

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
        final rentalRequestWithCarDetails = state.requestsWithCarDetails.first;
        return Scaffold(
          backgroundColor: ExternalAppColors.bg,
          appBar: AppBar(
            backgroundColor: ExternalAppColors.bg,
            leading: const BackButton(),
            title: const Text('Review Summary'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
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
