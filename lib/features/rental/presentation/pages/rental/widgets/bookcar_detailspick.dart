import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/home/presentation/bloc/selectedcar/selected_bloc.dart';
import 'package:rentit/features/home/presentation/bloc/selectedcar/selectedcar_state.dart';
import 'package:rentit/features/home/presentation/pages/widgets/rating.dart';
import 'package:rentit/features/rental/presentation/pages/rental/widgets/date_selection_widget.dart';
import 'package:rentit/features/rental/presentation/pages/rental/widgets/driver_selection_widget.dart';
import 'package:rentit/features/rental/presentation/pages/rental/widgets/location_selection.dart';
import 'package:rentit/utils/appcolors.dart';
import 'package:rentit/utils/primary_text.dart';
import 'package:rentit/widgets/custom_carbody_container.dart';

class BookcarDetailspick extends StatelessWidget {
  const BookcarDetailspick({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedCarBloc, SelectedCarState>(
      builder: (context, state) {
        if (state is CarSelected) {
          final car = state.car;
          return Container(
            decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
                color: ExternalAppColors.white),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomCarBodyContainer(
                        text: car.body.toUpperCase(),
                      ),
                      const StarRating(
                        rating: 4.9,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  PrimaryText(
                    text: "${car.make} ${car.model.toUpperCase()}",
                    color: ExternalAppColors.black,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: ExternalAppColors.grey.withOpacity(0.4),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  PrimaryText(
                    text: "BOOK CAR",
                    color: ExternalAppColors.grey,
                    size: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  PrimaryText(
                    text: "Rent Type",
                    color: ExternalAppColors.black,
                    size: 22,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const DriverSelectionWidget(),

                  const DateTimeSelectionScreen(),
                  Divider(
                    color: ExternalAppColors.grey.withOpacity(0.4),
                  ),
                  LocationSelectionWidget(),
                  
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
