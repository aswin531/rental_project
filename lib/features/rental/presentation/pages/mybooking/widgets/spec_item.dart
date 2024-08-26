import 'package:flutter/material.dart';

class SpecItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const SpecItem({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.blue,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(text),
      ],
    );
  }
}
