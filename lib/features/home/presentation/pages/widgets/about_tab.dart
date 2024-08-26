import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rentit/features/home/presentation/bloc/selectedcar/selected_bloc.dart';
import 'package:rentit/features/home/presentation/bloc/selectedcar/selectedcar_state.dart';
import 'package:rentit/utils/appcolors.dart';
import 'package:rentit/utils/primary_text.dart';

class AboutTabWidget extends StatelessWidget {
  const AboutTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedCarBloc, SelectedCarState>(
      builder: (context, state) {
        if (state is CarSelected) {
          final car = state.car;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryText(
                text: "Rental Partner",
                color: ExternalAppColors.black,
                size: 20,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(
                height: 8,
              ),
              ListTile(
                leading: const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage("assets/images/admin.jpg"),
                ),
                title: PrimaryText(
                  text: "Robin Stinson",
                  color: ExternalAppColors.black,
                  size: 22,
                  fontWeight: FontWeight.w600,
                ),
                subtitle: PrimaryText(
                  text: car.make,
                  color: ExternalAppColors.grey,
                  size: 17,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 23,
                      backgroundColor: ExternalAppColors.grey.withOpacity(0.15),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          FontAwesomeIcons.solidCommentDots,
                          color: ExternalAppColors.blue,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    CircleAvatar(
                      radius: 23,
                      backgroundColor: ExternalAppColors.grey.withOpacity(0.15),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          FontAwesomeIcons.phone,
                          color: ExternalAppColors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // buildSpecItem(Icons.star, 'Rating', widget.car.color),
              PrimaryText(
                text: "About",
                size: 20,
                color: ExternalAppColors.black,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(
                height: 8,
              ),
              PrimaryText(
                text:
                    "Pioneering mass production and accessible vehicles. From the Model T to electric F-150, innovation drives their legacy. A legacy of innovation, built for the American spirit.Empowering everyday journeys with reliable performance.//\$rentalPriceRange.start.toStringAsFixed(2)}/hr//\$rentalPriceRange.start.toStringAsFixed(2)}/hrPioneering mass production and accessible vehicles. From the Model T to electric F-150, innovation''",
                size: 18,
                color: ExternalAppColors.grey,
                fontWeight: FontWeight.w600,
              )
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
