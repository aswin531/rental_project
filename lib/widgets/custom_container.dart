import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final String text;
  final double padding;
  final double? width;
  final double? height;
  final Color? containerColor;
  final Color? textColor;
  final double? textSize;
  final BorderRadius borderRadius;

  const CustomContainer({
    super.key,
    required this.text,
    this.padding = 8.0,
    this.width,
    this.height,
    this.containerColor = const Color.fromRGBO(246, 246, 246, 1),
    this.textColor = Colors.blue,
    this.textSize = 14.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(5)),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: borderRadius,
      ),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: textSize),
        ),
      ),
    );
  }
}
