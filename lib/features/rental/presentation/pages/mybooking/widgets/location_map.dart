import 'package:flutter/material.dart';

class LocationMap extends StatelessWidget {
  const LocationMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Car Location',
            style: TextStyle(fontWeight: FontWeight.bold)),
        Container(
          height: 150,
          color: Colors.grey[300],
          child: const Center(child: Text('Map ')),
        ),
      ],
    );
  }
}