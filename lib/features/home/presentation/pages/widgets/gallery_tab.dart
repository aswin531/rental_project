import 'package:flutter/material.dart';

class GalleryTabWidget extends StatelessWidget {
  const GalleryTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Gallery', style: TextStyle(fontSize: 16)),
      ],
    );
  }
}