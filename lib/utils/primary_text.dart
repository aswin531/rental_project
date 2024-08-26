import 'package:flutter/material.dart';

class PrimaryText extends StatelessWidget {
  final double size;
  final FontWeight fontWeight;
  final Color color;
  final String text;
  final double height;
  // final TextOverflow? overflow;

  const PrimaryText({
    super.key,
    required this.text,
    this.fontWeight = FontWeight.w500,
    this.color = Colors.white,
    this.size = 25,
    this.height = 1.5,
    // this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      //overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: color,
        height: height,
        fontFamily: 'Poppins',
        fontSize: size,
        fontWeight: fontWeight,
      ),
    );
  }
}
