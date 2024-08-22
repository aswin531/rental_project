import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:rentit/features/bottomnav/presentation/widgets/navbar_items.dart';
import 'package:rentit/features/bottomnav/presentation/widgets/screen_list.dart';

PersistentTabView buildPersistentTabView(BuildContext context,
    PersistentTabController controller, int currentIndex) {
  return PersistentTabView(
    context,
    controller: controller,
    screens: screens(),
    items: navBarItems(),
    confineToSafeArea: true,
    backgroundColor: Colors.grey.shade900,
    handleAndroidBackButtonPress: true,
    resizeToAvoidBottomInset: true,
    stateManagement: true,
    navBarHeight: MediaQuery.of(context).viewInsets.bottom == 0
        ? kBottomNavigationBarHeight
        : 0.0,
    hideNavigationBarWhenKeyboardAppears: true,
    padding: const EdgeInsets.only(top: 8),
    isVisible: true,
    decoration: NavBarDecoration(
      borderRadius: BorderRadius.circular(10.0),
      colorBehindNavBar: Colors.grey,
    ),
    animationSettings: const NavBarAnimationSettings(
      navBarItemAnimation: ItemAnimationSettings(
        duration: Duration(milliseconds: 400),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimationSettings(
        animateTabTransition: true,
        duration: Duration(milliseconds: 200),
        screenTransitionAnimationType: ScreenTransitionAnimationType.slide,
      ),
    ),
  );
}
