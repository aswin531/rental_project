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
                const SizedBox(
                  height: 10,
                ),
                const Expanded(child: BookcarDetailspick()),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 5),
                      ),
                    ],
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(15)),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BookingButton(
                        carId: car.carId,
                      )),
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
