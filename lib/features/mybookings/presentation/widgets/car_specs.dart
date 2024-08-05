import 'package:flutter/material.dart';
import 'package:rentit/features/mybookings/presentation/widgets/spec_items.dart';

class CarSpecs extends StatelessWidget {
  const CarSpecs({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SpecItem(icon: Icons.settings, text: 'Manual'),
        SpecItem(icon: Icons.local_gas_station, text: 'Petrol'),
        SpecItem(icon: Icons.people, text: '5 Seats'),
      ],
    );
  }
}