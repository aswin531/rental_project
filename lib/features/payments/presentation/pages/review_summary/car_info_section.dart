import 'package:flutter/material.dart';
import 'package:rentit/utils/appcolors.dart';
import 'package:rentit/utils/primary_text.dart';
import 'package:rentit/widgets/custom_container.dart';

class CarInfoSection extends StatelessWidget {
  final String body;
  final String model;
  final String brand;
  final String rentalPrice;
  final String imageUrl;
  const CarInfoSection(
      {super.key,
      required this.body,
      required this.model,
      required this.brand,
      required this.rentalPrice,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(
            imageUrl,
            width: 180,
            height: 180,
            fit: BoxFit.fitWidth,
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomContainer(
              text: body,
              containerColor: Colors.white,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                PrimaryText(
                  text: brand,
                  size: 24,
                  color: ExternalAppColors.black,
                ),
                PrimaryText(
                  text: model,
                  size: 24,
                  color: ExternalAppColors.black,
                ),
              ],
            ),
            // PrimaryText(
            //   text: rentalPrice,
            //   color: ExternalAppColors.black,
            // ),
          ],
        ),
        const SizedBox(width: 8),
        const Icon(Icons.star, color: Colors.yellow, size: 16),
        const Text('4.8', style: TextStyle(fontSize: 12)),
      ],
    );
  }
}

class DateTimeSection extends StatelessWidget {
  const DateTimeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PrimaryText(
              text: 'Pick-Up Date & Time',
              color: ExternalAppColors.grey,
              size: 18,
            ),
            PrimaryText(
              text: 'October 04 | 10:00 AM',
              color: ExternalAppColors.black,
              size: 17,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PrimaryText(
              text: 'Return Date & Time',
              color: ExternalAppColors.grey,
              size: 18,
            ),
            PrimaryText(
              text: 'October 05 | 10:00 AM',
              color: ExternalAppColors.black,
              size: 17,
            ),
          ],
        ),
        const SizedBox(height: 8),
        PrimaryText(
          text: 'Self Driver',
          color: ExternalAppColors.grey,
          size: 18,
        ),
      ],
    );
  }
}

class PricingSection extends StatelessWidget {
  const PricingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PrimaryText(
              text: 'Amount',
              color: ExternalAppColors.grey,
              size: 18,
            ),
            PrimaryText(
              text: '\$30.00/hr',
              color: ExternalAppColors.black,
              size: 17,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PrimaryText(
              text: 'Total Hours',
              color: ExternalAppColors.grey,
              size: 18,
            ),
            PrimaryText(
              text: '24',
              color: ExternalAppColors.black,
              size: 17,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PrimaryText(
              text: 'Fees',
              color: ExternalAppColors.grey,
              size: 18,
            ),
            PrimaryText(
              text: '\$50.00',
              color: ExternalAppColors.black,
              size: 17,
            ),
          ],
        ),
        const Divider(),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PrimaryText(
              text: 'Total',
              color: ExternalAppColors.grey,
              size: 18,
            ),
            PrimaryText(
              color: ExternalAppColors.black,
              text: '\$770.00',
            ),
          ],
        ),
        const Divider(),
        const SizedBox(height: 20),
      ],
    );
  }
}

class PaymentMethodSection extends StatelessWidget {
  const PaymentMethodSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: PrimaryText(
            text: 'Stripe',
            color: ExternalAppColors.white,
            size: 18,
          ),
        ),
        const SizedBox(width: 12),
        PrimaryText(
          text: 'Change',
          color: ExternalAppColors.blue,
          size: 17,
        ),
      ],
    );
  }
}

class ContinueButton extends StatelessWidget {
  const ContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.blueAccent, // Button background color
          foregroundColor: Colors.white, // Text color
          shadowColor: Colors.blueAccent.withOpacity(0.5), // Shadow color
          elevation: 5, // Button elevation
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Rounded corners
            side: const BorderSide(
                color: Colors.blue, width: 2), // Border color and width
          ),
        ),
        child: const Text(
          'Continue',
          style: TextStyle(
            fontSize: 18, // Font size
            fontWeight: FontWeight.bold, // Font weight
            letterSpacing: 1.2, // Spacing between letters
          ),
        ),
      ),
    );
  }
}
