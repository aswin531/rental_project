import 'package:flutter/material.dart';
import 'package:rentit/utils/primary_text.dart';

class CustomCarBodyContainer extends StatelessWidget {
  final String text;
  final Color containerColor;
  final Color textColor;
  final double borderRadius;
  final double fontSize;
  final EdgeInsets padding;

  const CustomCarBodyContainer({
    super.key,
    required this.text,
    this.containerColor = const Color.fromRGBO(246, 246, 246, 1),
    this.textColor = Colors.blue,
    this.borderRadius = 5.0,
    this.fontSize = 17.0,
    this.padding = const EdgeInsets.all(8.0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Padding(
        padding: padding,
        child: PrimaryText(
          text: text.toUpperCase(),
          size: fontSize,
          color: textColor,
        ),
      ),
    );
  }
}
