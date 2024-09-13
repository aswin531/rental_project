import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rentit/features/onboarding/widgets/onboardingpage.dart';
import 'package:rentit/features/onboarding/widgets/onboardingpagedata.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  PageController? pageController;
  int currentIndex = 0;
  double percentage = 0.25;

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  final List<OnboardingPageData> pages = [
    OnboardingPageData(
      backgroundColor: const Color(0xFFF0CF69),
      imagePath: 'assets/icons/onboarding1F0CF69.svg',
      text: 'Welcome to Rent It!',
      subText: "Find and rent the car that fits your needs.",
      crossAxisAlignment: CrossAxisAlignment.start,
    ),
    OnboardingPageData(
      backgroundColor: const Color(0xFFB7ABFD),
      imagePath: 'assets/icons/onboarding2B7ABFD.svg',
      text: 'Discover a range of cars.',
      subText: 'Choose from a variety of vehicles.',
      crossAxisAlignment: CrossAxisAlignment.end,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        itemCount: pages.length,
        onPageChanged: (int index) {
          setState(() {
            currentIndex = index;
            percentage = (index + 1) / pages.length;
          });
        },
        itemBuilder: (context, index) {
          final page = pages[index];
          return OnboardingPage(
            backgroundColor: page.backgroundColor,
            imagePath: page.imagePath,
            text: page.text,
            subText: page.subText,
            crossAxisAlignment: page.crossAxisAlignment,
            currentIndex: currentIndex,
            pages: pages,
            percentage: percentage,
            onNextPressed: () {
              if (currentIndex < pages.length - 1) {
                pageController!.nextPage(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
              }
            },
            onSkipPressed: () {},
            pageController: pageController!,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    pageController?.dispose();
    super.dispose();
  }
}
