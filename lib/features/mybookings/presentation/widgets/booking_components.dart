import 'package:flutter/material.dart';
import 'package:rentit/features/mybookings/presentation/widgets/booking_buttons.dart';
import 'package:rentit/features/mybookings/presentation/widgets/car_specs.dart';
import 'package:rentit/features/mybookings/presentation/widgets/location_map.dart';
import 'package:rentit/features/mybookings/presentation/widgets/req_car_detail.dart';

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