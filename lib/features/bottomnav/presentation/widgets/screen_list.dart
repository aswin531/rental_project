import 'package:flutter/material.dart';
import 'package:rentit/features/home/presentation/pages/carlistscreen.dart';
import 'package:rentit/features/profile/pages/profile.dart';
import 'package:rentit/features/profile/widgets/account_page.dart';

List<Widget> screens() {
  return const [
    CarListScreen(),
    MainProfileScreen(),
    AccountScreenWidget(),
  ];
}
