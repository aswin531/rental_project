import 'package:flutter/material.dart';
import 'package:rentit/features/profile/presentation/pages/profile_dash.dart';
import 'package:rentit/features/home/presentation/pages/carlistscreen.dart';
import 'package:rentit/features/location/presentation/pages/picupdropoff.dart';
import 'package:rentit/features/rental/presentation/pages/mybooking/booking.dart';

List<Widget> screens() {
  return [
    const CarListScreen(),
    const LocationMapTestWidget(),
    const BookingPage(),
    const ProfileDashboard(),
  ];
}
