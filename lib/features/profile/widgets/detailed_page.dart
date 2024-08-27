import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final String title;

  const DetailsPage({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('Details for $title')),
    );
  }
}
