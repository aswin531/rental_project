import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rentit/features/location/presentation/pages/picupdropoff.dart';
import 'package:rentit/utils/appcolors.dart';
import 'package:rentit/utils/primary_text.dart';

class GpsReminderDialog extends StatelessWidget {
  const GpsReminderDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text("Enable GPS"),
      content: PrimaryText(
          size: 13,
          color: ExternalAppColors.black,
          text:
              "GPS is required to select your location.\n Please enable GPS in your settings."),
      actions: [
        CupertinoDialogAction(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          child: const Text("Enable GPS"),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const LocationMapTestWidget(),
            ));
          },
        ),
      ],
    );
  }

  static void show(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) => const GpsReminderDialog(),
    );
  }
}
