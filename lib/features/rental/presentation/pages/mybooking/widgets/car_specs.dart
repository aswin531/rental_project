import 'package:flutter/material.dart';
import 'package:rentit/features/rental/presentation/pages/mybooking/widgets/spec_item.dart';

class CarSpecs extends StatelessWidget {
  final String transimission;
  final String engine;
  final int seatCapacity;
  const CarSpecs(
      {super.key,
      required this.transimission,
      required this.engine,
      required this.seatCapacity});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SpecItem(icon: Icons.settings, text: transimission),
        SpecItem(icon: Icons.local_gas_station, text: engine),
        SpecItem(icon: Icons.people, text: seatCapacity.toString()),
      ],
    );
  }
}
