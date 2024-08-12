import 'package:flutter/material.dart';

class BrandLogoWidget extends StatelessWidget {
  final String logoUrl;
  final String brandName;
  final VoidCallback onTap;

  const BrandLogoWidget({
    super.key,
    required this.logoUrl,
    required this.brandName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          ClipOval(
            child: Image.network(
              logoUrl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            brandName,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
