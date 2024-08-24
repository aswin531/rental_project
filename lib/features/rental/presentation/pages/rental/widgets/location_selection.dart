import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_bloc.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_event.dart';
import 'package:rentit/features/rental/presentation/pages/rental/widgets/gps_reminder_dialogue.dart';
import 'package:rentit/utils/appcolors.dart';
import 'package:rentit/utils/primary_text.dart';

class LocationSelectionWidget extends StatelessWidget {
  final TextEditingController pickupLocationController =
      TextEditingController();
  final TextEditingController dropOffLocationController =
      TextEditingController();

  LocationSelectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 5,
        ),
        PrimaryText(
          text: "Location",
          color: ExternalAppColors.black,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                    labelText: "Pick-Up Location",
                    border: OutlineInputBorder()),
                controller: pickupLocationController,
                onChanged: (value) {
                  context
                      .read<RentalRequestBloc>()
                      .add(UpdatePickupLocationEvent(value));
                },
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            CircleAvatar(
              radius: 25,
              child: IconButton(
                onPressed: () {
                  showGpsReminderDialog(context);
                },
                icon: const Icon(FontAwesomeIcons.locationDot),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                    labelText: "Pick-Up Location",
                    border: OutlineInputBorder()),
                controller: dropOffLocationController,
                onChanged: (value) {
                  context
                      .read<RentalRequestBloc>()
                      .add(UpdateDropOffLocationEvent(value));
                },
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            // ModalBarrier(
            //   color: Colors.black.withOpacity(0.5),
            //   dismissible: false,
            // ),
            CircleAvatar(
              radius: 25,
              child: IconButton(
                onPressed: () {
                  GpsReminderDialog.show(context);
                },
                icon: const Icon(FontAwesomeIcons.mapLocationDot),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: BorderDirectional(
                start: BorderSide(color: ExternalAppColors.blue, width: 8)),
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(10),
          ),
        )
      ],
    );
  }
}

void showGpsReminderDialog(BuildContext context) {
  GpsReminderDialog.show(context);
}
