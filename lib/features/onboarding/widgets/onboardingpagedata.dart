import 'package:flutter/material.dart';

class OnboardingPageData {
  final Color backgroundColor;
  final String imagePath;
  final String text;
  final String subText;
  final CrossAxisAlignment crossAxisAlignment;

  OnboardingPageData({
    required this.backgroundColor,
    required this.imagePath,
    required this.text,
    required this.crossAxisAlignment,
    required this.subText,
  });
}
