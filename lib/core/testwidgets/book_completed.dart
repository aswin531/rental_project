import 'package:flutter/material.dart';
import 'package:rentit/utils/primary_text.dart';

class CarRentalWidget extends StatelessWidget {
  final String? imageUrl;
  final String? rating;
  final String? carName;
  final String? price;
  final List<CarFeature>? features;
  final VoidCallback? onRebook;
  final VoidCallback? onAddReview;
  final String? rebookButtonText;
  final String? reviewButtonText;

  const CarRentalWidget({
    super.key,
    this.imageUrl,
    this.rating,
    this.carName,
    this.price,
    this.features,
    this.onRebook,
    this.onAddReview,
    this.rebookButtonText = 'Re-Book',
    this.reviewButtonText = 'Add Review',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRating(),
          const SizedBox(height: 8),
          const PrimaryText(
            text: "Image Heere",
            color: Colors.black,
            size: 16,
            fontWeight: FontWeight.bold,
          ),
          // Image.network(imageUrl ?? "image here",
          //     height: 120, fit: BoxFit.contain),
          const SizedBox(height: 8),
          PrimaryText(
            text: carName ?? "CarName",
            color: Colors.black,
            size: 16,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 4),
          PrimaryText(
            text: price ?? "Price",
            color: Colors.blue,
            size: 14,
          ),
          const SizedBox(height: 8),
          _buildFeatures(),
          const SizedBox(height: 16),
          _buildButton(rebookButtonText ?? "rebookButtonText", onRebook, true),
          const SizedBox(height: 8),
          _buildButton(
              reviewButtonText ?? "reviewButtonText", onAddReview, false),
        ],
      ),
    );
  }

  Widget _buildRating() {
    return const Row(
      children: [
        Icon(Icons.star, color: Colors.amber, size: 20),
        SizedBox(width: 4),
        PrimaryText(
          text: "4.9",
          color: Colors.black,
          size: 16,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }

  Widget _buildFeatures() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: features!.map((feature) => _buildFeatureItem(feature)).toList(),
    );
  }

  Widget _buildFeatureItem(CarFeature feature) {
    return Row(
      children: [
        Icon(feature.icon, size: 16, color: Colors.grey),
        const SizedBox(width: 4),
        PrimaryText(
          text: feature.text,
          color: Colors.grey,
          size: 12,
        ),
      ],
    );
  }

  Widget _buildButton(String text, VoidCallback? onPressed, bool isPrimary) {
    return SizedBox(
      width: double.infinity,
      child: isPrimary
          ? ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(double.infinity, 40),
              ),
              child: PrimaryText(
                text: text,
                color: Colors.white,
                size: 14,
              ),
            )
          : OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.blue,
                side: const BorderSide(color: Colors.blue),
                minimumSize: const Size(double.infinity, 40),
              ),
              child: PrimaryText(
                text: text,
                color: Colors.blue,
                size: 14,
              ),
            ),
    );
  }
}

class CarFeature {
  final IconData icon;
  final String text;

  CarFeature({required this.icon, required this.text});
}
