import 'package:flutter/material.dart';
import 'package:rentit/features/home/presentation/pages/carlistscreen.dart';
import 'package:rentit/features/location/presentation/pages/location.dart';
import 'package:rentit/features/location/presentation/pages/picupdropoff.dart';
import 'package:rentit/features/profile/pages/profile.dart';
import 'package:rentit/features/rental/presentation/pages/mybooking/booking.dart';

List<Widget> screens() {
  return [
    const CarListScreen(),
    const LocationMapTestWidget(),
    const BookingPage(),
    RequestStatusCard(),
    const MainProfileScreen(),
  ];
}
