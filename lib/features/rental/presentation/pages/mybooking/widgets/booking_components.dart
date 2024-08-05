import 'package:flutter/material.dart';
import 'package:rentit/features/rental/presentation/pages/mybooking/widgets/booking_button.dart';
import 'package:rentit/features/rental/presentation/pages/mybooking/widgets/car_specs.dart';
import 'package:rentit/features/rental/presentation/pages/mybooking/widgets/location_map.dart';
import 'package:rentit/features/rental/presentation/pages/mybooking/widgets/req_car_details.dart';

class BookingContent extends StatelessWidget {
  const BookingContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarDetails(),
          SizedBox(height: 20),
          CarSpecs(),
          SizedBox(height: 20),
          LocationMap(),
          SizedBox(height: 20),
          ActionButtons(),
        ],
      ),
    );
  }
}