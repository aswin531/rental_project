import 'package:flutter/material.dart';
import 'package:rentit/core/testwidgets/review_summary/review_summary_card.dart';
import 'package:rentit/features/home/presentation/pages/carlistscreen.dart';
import 'package:rentit/features/location/presentation/pages/picupdropoff.dart';
import 'package:rentit/features/profile/pages/profile.dart';
import 'package:rentit/features/rental/presentation/pages/mybooking/booking.dart';

List<Widget> screens() {
  return [
    const CarListScreen(),
    const LocationMapTestWidget(),
    const BookingPage(),
    ReviewSummaryScreen(),
  //    CarRentalWidget(
  //      features: [
  //   CarFeature(icon: Icons.settings, text: 'Manual'),
  //   CarFeature(icon: Icons.local_gas_station, text: 'Diesel'),
  //   CarFeature(icon: Icons.people, text: '7 Seats'),
  // ],
  //   ),
    const MainProfileScreen(),
  ];
}
