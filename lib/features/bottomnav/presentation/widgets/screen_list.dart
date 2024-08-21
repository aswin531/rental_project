import 'package:flutter/material.dart';
import 'package:rentit/features/home/presentation/pages/carlistscreen.dart';
import 'package:rentit/features/location/presentation/pages/testpage.dart';
import 'package:rentit/features/profile/pages/profile.dart';
import 'package:rentit/features/rental/presentation/pages/mybooking/booking.dart';

List<Widget> screens() {
  return [
    const CarListScreen(),
    LocationTestPage(),
    const BookingPage(),
    const MainProfileScreen(),
  ];
}
