// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rentit/utils/appcolors.dart';
import 'package:rentit/utils/primary_text.dart';

class DriverSelectionWidget extends StatefulWidget {
  const DriverSelectionWidget({super.key});

  @override
  _DriverSelectionWidgetState createState() => _DriverSelectionWidgetState();
}

class _DriverSelectionWidgetState extends State<DriverSelectionWidget> {
  bool isSelfDriverSelected = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isSelfDriverSelected = true;
                });
              },
              child: Container(
                width: 200,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isSelfDriverSelected ? Colors.blue : Colors.grey[300],
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person,
                        size: 25,
                        color:
                            isSelfDriverSelected ? Colors.white : Colors.black),
                    const SizedBox(width: 8),
                    PrimaryText(
                      text: "Self Driver",
                      color: isSelfDriverSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                      size: 22,
                    )
                  ],
                ),
              ),
            ),
            Icon(
              FontAwesomeIcons.gripLinesVertical,
              color: ExternalAppColors.blue.withOpacity(0.5),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isSelfDriverSelected = false;
                });
              },
              child: Container(
                width: 200,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: !isSelfDriverSelected
                      ? ExternalAppColors.blue
                      : ExternalAppColors.bg,
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.drive_eta_rounded,
                        size: 25,
                        color: !isSelfDriverSelected
                            ? Colors.white
                            : Colors.black),
                    const SizedBox(width: 8),
                    PrimaryText(
                      text: "With Driver",
                      size: 22,
                      color:
                          !isSelfDriverSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (!isSelfDriverSelected)
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Driver Details",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        const TextSpan(
                          text:
                              'Youve selected an additional driver. You will be charged',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: ' ₹200/hr',
                          style: TextStyle(
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              color: ExternalAppColors.blue),
                        ),
                        const TextSpan(
                          text: ' for this service.',
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
      ],
    );
  }
}
