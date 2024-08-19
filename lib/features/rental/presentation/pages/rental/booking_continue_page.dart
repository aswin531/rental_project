import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rentit/features/home/presentation/bloc/selectedcar/selected_bloc.dart';
import 'package:rentit/features/home/presentation/bloc/selectedcar/selectedcar_state.dart';
import 'package:rentit/features/rental/presentation/pages/rental/widgets/bookcar_detailspick.dart';
import 'package:rentit/features/rental/presentation/pages/rental/widgets/booking_button.dart';
import 'package:rentit/utils/appcolors.dart';
import 'package:rentit/utils/custom_appbar.dart';
import 'package:rentit/utils/network_images.dart';

class BookingContinuePage extends StatelessWidget {
  const BookingContinuePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ExternalAppColors.bg,
      body: BlocBuilder<SelectedCarBloc, SelectedCarState>(
        builder: (context, state) {
          if (state is CarSelected) {
            final car = state.car;

            return Column(
              children: [
                CustomAppbar(
                  title: "Book Car",
                  onBackPressed: () => context.pop(),
                ),
                const SizedBox(height: 15),
                CustomCachedNetworkImage(
                  imageUrl: car.imageUrls.last,
                ),
                const SizedBox(height: 8),
                const Expanded(child: BookcarDetailspick()),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BookingButton(
                    carId: car.carId,
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
