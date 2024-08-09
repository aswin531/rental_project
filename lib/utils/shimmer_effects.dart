import 'package:flutter/material.dart';

class ShimmerBrandLogo extends StatelessWidget {
  const ShimmerBrandLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}

class ShimmerCarCard extends StatelessWidget {
  const ShimmerCarCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 120,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 8),
          Container(
            width: 150,
            height: 20,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 8),
          Container(
            width: 100,
            height: 20,
            color: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }
}