import 'package:flutter/material.dart';
import 'package:rentit/utils/appcolors.dart';
import 'package:rentit/utils/primary_text.dart';

class ReviewTabWidget extends StatelessWidget {
  const ReviewTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PrimaryText(
          text: "Reviews",
          color: ExternalAppColors.black,
          size: 20,
          fontWeight: FontWeight.w600,
        ),
        ListTile(
          leading: const CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage("assets/images/Ted_Mosby.jpg"),
          ),
          title: PrimaryText(
            text: "Ted Mosby",
            color: ExternalAppColors.black,
            size: 22,
            fontWeight: FontWeight.w600,
          ),
          subtitle: PrimaryText(
            text: "Author",
            color: ExternalAppColors.grey,
            size: 17,
          ),
          trailing: PrimaryText(
            text: '11 months ago',
            color: ExternalAppColors.grey,
            size: 14,
          ),
        ),
      ],
    );
  }
}
