import 'package:flutter/material.dart';
import 'package:rentit/utils/appcolors.dart';
import 'package:rentit/utils/primary_text.dart';

class StarRating extends StatelessWidget {
  final double rating;

  const StarRating({
    super.key,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.star,
          color: Colors.amber,
          size: 25,
        ),
        const SizedBox(
          width: 3,
        ),
        PrimaryText(
          text: rating.toStringAsFixed(1),
          color: ExternalAppColors.black,
          fontWeight: FontWeight.w500,
          size: 18,
        ),
      ],
    );
  }
}
