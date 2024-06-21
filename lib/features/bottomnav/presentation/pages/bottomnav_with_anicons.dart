import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentit/core/constants/colors.dart';
import 'package:rentit/features/bottomnav/presentation/widgets/nav_item_model.dart';
import 'package:rive/rive.dart';

class BottomNavBarWithIcons extends StatefulWidget {
  const BottomNavBarWithIcons({super.key});

  @override
  State<BottomNavBarWithIcons> createState() => _BottomNavBarWithIconsState();
}

class _BottomNavBarWithIconsState extends State<BottomNavBarWithIcons> {
  final List<SMIBool?> riveInputs = List.filled(bottomNavItems.length, null);
  final List<StateMachineController?> controllers = List.filled(bottomNavItems.length, null);
  int selectedNavIndex = 0;
  final List<String> pages = ["Home", "Search", "History", "Notification", "Profile"];

  void animateTheIcon(int index) {
    if (riveInputs[index] != null) {
      riveInputs[index]!.value = true;
      Future.delayed(
        const Duration(seconds: 1),
        () {
          if (riveInputs[index] != null) {
            riveInputs[index]!.value = false;
          }
        },
      );
    }
  }

  void riveOnInit(Artboard artboard, {required String stateMachineName, required int index}) {
    final controller = StateMachineController.fromArtboard(artboard, stateMachineName);
    if (controller != null) {
      artboard.addController(controller);
      final input = controller.findInput<bool>("active") as SMIBool?;
      if (input != null) {
        setState(() {
          controllers[index] = controller;
          riveInputs[index] = input;
        });
      } else {
        print("Error: SMIBool 'active' not found for index $index");
      }
    } else {
      print("Error: StateMachineController is null for index $index");
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        body: Center(
          child: Text(pages[selectedNavIndex]),
        ),
        bottomNavigationBar: Container(
          height: 56.h,
          margin: EdgeInsets.symmetric(horizontal: 24.w),
          padding: EdgeInsets.all(8.h),
          decoration: BoxDecoration(
            color: Colors.blueGrey[600],
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: primary.withOpacity(0.3),
                offset: const Offset(0, 20),
                blurRadius: 20,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(bottomNavItems.length, (index) {
              final riveIcon = bottomNavItems[index].rive;
              return GestureDetector(
                onTap: () {
                  animateTheIcon(index);
                  setState(() {
                    selectedNavIndex = index;
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedBar(
                      isActive: selectedNavIndex == index,
                    ),
                    SizedBox(
                      height: 36.h,
                      width: 36.w,
                      child: Opacity(
                        opacity: selectedNavIndex == index ? 1 : 0.5,
                        child: RiveAnimation.asset(
                          riveIcon.src,
                          artboard: riveIcon.artboard,
                          onInit: (artboard) {
                            riveOnInit(artboard, stateMachineName: riveIcon.stateMachineName, index: index);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class AnimatedBar extends StatelessWidget {
  const AnimatedBar({
    super.key,
    required this.isActive,
  });

  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 2),
      height: 2,
      width: isActive ? 18 : 0,
      decoration:
          BoxDecoration(color: white, borderRadius: BorderRadius.circular(5)),
    );
  }
}
