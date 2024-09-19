import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
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
      text: 'Your Journey Starts Here',
      subText: 'Find the perfect car for your adventure.',
      crossAxisAlignment: CrossAxisAlignment.end,
    ),
    OnboardingPageData(
      backgroundColor: const Color(0xFFEFB491),
      imagePath: 'assets/icons/onboarding3EFB491.svg',
      text: 'Rent It, Anywhere, Anytime',
      subText: 'Enjoy the freedom of flexible car rentals.',
      crossAxisAlignment: CrossAxisAlignment.end,
    ),
    OnboardingPageData(
      // ignore: use_full_hex_values_for_flutter_colors
      backgroundColor: const Color(0xff95b6ffd),
      imagePath: 'assets/icons/onboarding495B6FF.svg',
      text: 'Discover a range of cars.',
      subText: 'Choose from a variety of vehicles.',
      crossAxisAlignment: CrossAxisAlignment.center,
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
              } else {
                // replaces the current onboarding route-preventing going back to it
                context.replace(
                    '/loginRegSelection'); 
              }
            },
            onSkipPressed: () {
              context.replace('/loginRegSelection');
            },
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
