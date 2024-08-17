import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rentit/features/home/presentation/bloc/selectedcar/selected_bloc.dart';
import 'package:rentit/features/home/presentation/bloc/selectedcar/selectedcar_state.dart';
import 'package:rentit/features/rental/presentation/pages/rental/widgets/bookcar_detailspick.dart';
import 'package:rentit/utils/appcolors.dart';
import 'package:rentit/utils/custom_appbar.dart';
import 'package:rentit/utils/network_images.dart';
import 'package:rentit/utils/primary_text.dart';

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
                CustomCachedNetworkImage(
                  imageUrl: car.imageUrls.last,
                ),
                const SizedBox(
                  height: 5,
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
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(15)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                        elevation: 5,
                        animationDuration: const Duration(seconds: 1),
                        minimumSize: const Size(470, 40),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        shadowColor: Colors.blueAccent,
                      ),
                      onPressed: () {},
                      child: const PrimaryText(
                        text: "Continue",
                        color: Colors.white,
                      ),
                    ),
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
