import 'package:flutter/material.dart';
import 'package:rentit/features/home/presentation/pages/carlistscreen.dart';
import 'package:rentit/features/profile/pages/profile.dart';
import 'package:rentit/features/rental/presentation/pages/mybooking/booking.dart';
import 'package:rentit/testui.dart';

List<Widget> screens() {
  return  [
   const CarListScreen(),
   const TestCarListScreen(),
   const BookingPage(),
    const MainProfileScreen(),
  ];
}
