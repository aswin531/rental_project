import 'package:flutter/material.dart';
import 'package:rentit/features/onboarding/onboarding.dart';
import 'package:rentit/features/profile/presentation/pages/profile_dash.dart';
import 'package:rentit/features/home/presentation/pages/carlistscreen.dart';
import 'package:rentit/features/location/presentation/pages/picupdropoff.dart';
import 'package:rentit/features/rental/presentation/pages/mybooking/booking.dart';

List<Widget> screens() {
  return [
    const CarListScreen(),
    const LocationMapTestWidget(),
    const BookingPage(),
    const OnboardingScreen(),
   // ReviewScreen(),
   // UserIntroProfileDetailsScreen(),
//const GooglePayButtonWidget(amount: '333   ',currency: '30000',),
    //    CarRentalWidget(
    //      features: [
    //   CarFeature(icon: Icons.settings, text: 'Manual'),
    //   CarFeature(icon: Icons.local_gas_station, text: 'Diesel'),
    //   CarFeature(icon: Icons.people, text: '7 Seats'),
    // ],
    //   ),
    const ProfileDashboard(),
  ];
}
