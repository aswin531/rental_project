import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rentit/features/onboarding/widgets/onboardingpage.dart';
import 'package:rentit/features/onboarding/widgets/onboardingpagedata.dart';

class OnboardingScreen extends StatelessWidget {
  final List<OnboardingPageData> pages = [
    OnboardingPageData(
        backgroundColor: const Color(0xFFF0CF69),
        imagePath: 'assets/icons/onboarding1F0CF69.svg',
        text:
            'Welcome to Rent It! Your go-to app for convenient and hassle-free car rentals.',
        subText: "Find and rent the car that fits your needs, hassle-free.",
        crossAxisAlignment: CrossAxisAlignment.start),
    OnboardingPageData(
        backgroundColor: const Color(0xFFB7ABFD),
        imagePath: 'assets/icons/onboarding2B7ABFD.svg',
        text: 'Discover a diverse range of cars to suit your needs.',
        subText: 'Choose from a wide variety of vehicles, whenever you need.',
        crossAxisAlignment: CrossAxisAlignment.end),
    OnboardingPageData(
        backgroundColor: const Color(0xFFEFB491),
        imagePath: 'assets/icons/onboarding3EFB491.svg',
        text:
            'Choose your pickup and drop-off locations, select your desired car, and complete your booking.',
        subText: 'Rent your car with just a few clicks, fast and secure.',
        crossAxisAlignment: CrossAxisAlignment.end),
    OnboardingPageData(
        backgroundColor: const Color(0xFF95B6FF),
        imagePath: 'assets/icons/onboarding495B6FF.svg',
        text: 'Experience the convenience of hassle-free car rentals.',
        subText: 'Affordable rates, no commitments, enjoy your ride.',
        crossAxisAlignment: CrossAxisAlignment.center),
  ];

  OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      // statusBarIconBrightness: Brightness.light,
    ));
    return Scaffold(
      body: PageView.builder(
        itemCount: pages.length,
        itemBuilder: (context, index) {
          final page = pages[index];
          return OnboardingPage(
            backgroundColor: page.backgroundColor,
            imagePath: page.imagePath,
            text: page.text,
            subText: page.subText,
            crossAxisAlignment: page.crossAxisAlignment,
          );
        },
      ),
    );
  }
}
