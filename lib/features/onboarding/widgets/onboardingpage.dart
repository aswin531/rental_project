import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rentit/utils/appcolors.dart';
import 'package:rentit/utils/primary_text.dart';

class OnboardingPage extends StatelessWidget {
  final Color backgroundColor;
  final String imagePath;
  final String text;
  final String subText;
  final CrossAxisAlignment crossAxisAlignment;

  const OnboardingPage({
    super.key,
    required this.backgroundColor,
    required this.imagePath,
    required this.text,
    required this.subText,
    required this.crossAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          PrimaryText( 
            text: subText,
            color: ExternalAppColors.white,
          ),
          const SizedBox(height: 24),
          SvgPicture.asset(imagePath),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
