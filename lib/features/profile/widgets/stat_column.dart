import 'package:flutter/material.dart';

class StatColumn extends StatelessWidget {
  final String value;
  final String label;

  const StatColumn({
    required this.value,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        Text(label,
            style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }
}
