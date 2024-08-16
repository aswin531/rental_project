import 'package:flutter/material.dart';
import 'package:rentit/utils/appcolors.dart';
import 'package:rentit/utils/primary_text.dart';

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
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Colors.grey.shade200),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.grey.shade200,
                radius: 35,
                child: Image.network(
                  logoUrl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          PrimaryText(
            text: brandName,
            size: 16,
            color: ExternalAppColors.black,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
