import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rentit/features/onboarding/widgets/onboardingpagedata.dart';
import 'package:rentit/utils/appcolors.dart';
import 'package:rentit/utils/primary_text.dart';

class OnboardingPage extends StatelessWidget {
  final Color backgroundColor;
  final String imagePath;
  final String text;
  final String subText;
  final CrossAxisAlignment crossAxisAlignment;
  final int currentIndex;
  final List<OnboardingPageData> pages;
  final double percentage;
  final VoidCallback onNextPressed;
  final VoidCallback onSkipPressed;
  final PageController pageController;

  const OnboardingPage({
    super.key,
    required this.backgroundColor,
    required this.imagePath,
    required this.text,
    required this.subText,
    required this.crossAxisAlignment,
    required this.currentIndex,
    required this.pages,
    required this.percentage,
    required this.onNextPressed,
    required this.onSkipPressed,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: crossAxisAlignment,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: PrimaryText(
                    text: text,
                    color: ExternalAppColors.white,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.topCenter,
                  child: PrimaryText(
                    text: subText,
                    size: 20,
                    color: ExternalAppColors.white,
                  ),
                ),
                const SizedBox(height: 55),
                SvgPicture.asset(imagePath),
                const SizedBox(height: 24),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: List.generate(
                          pages.length,
                          (index) => buildDot(index, context),
                        ),
                      ),
                      const SizedBox(height: 10),
                      CupertinoButton(
                        onPressed: onSkipPressed,
                        child: PrimaryText(
                          text: "Skip",
                          color: ExternalAppColors.white,
                        ),
                      ),
                    ],
                  ),
                  CupertinoButton(
                    onPressed: onNextPressed,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: 55,
                          width: 55,
                          child: CircularProgressIndicator(
                            value: percentage,
                            backgroundColor: ExternalAppColors.white,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Color.fromARGB(255, 238, 230, 218),
                            ),
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: ExternalAppColors.white,
                          child: Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: backgroundColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  AnimatedContainer buildDot(int index, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      height: 8,
      margin: const EdgeInsets.only(right: 8),
      width: currentIndex == index ? 24 : 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index ? ExternalAppColors.white : Colors.white38,
      ),
    );
  }
}
