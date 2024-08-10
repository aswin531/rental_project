import 'package:flutter/material.dart';
import 'package:rentit/features/home/presentation/pages/carlistscreen.dart';
import 'package:rentit/features/home/presentation/pages/widgets/all_brands_page.dart';
import 'package:rentit/features/profile/pages/profile.dart';
import 'package:rentit/features/rental/presentation/pages/mybooking/booking.dart';

List<Widget> screens() {
  return [
    const CarListScreen(),
    const AllBrandsPage(),
    const BookingPage(),
    const MainProfileScreen(),
  ];
}
