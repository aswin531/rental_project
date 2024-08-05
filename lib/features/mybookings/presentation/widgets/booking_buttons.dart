import 'package:flutter/material.dart';
import 'package:rentit/utils/primary_text.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: const PrimaryText(
              text: 'E-Ticket',
              size: 14,
            )),
      ],
    );
  }
}
