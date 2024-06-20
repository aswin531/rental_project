import 'package:flutter/material.dart';
import 'package:rentit/core/constants/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  final Color primaryColor = primary;
  final Color custFormFieldBg = const Color(0xFFF1F4FF);

  CustomTextFormField({
    super.key,
    required this.labelText,
    this.obscureText = false,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        filled: true,
        fillColor: custFormFieldBg,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryColor),
        ),
        labelStyle: const TextStyle(
          color: Colors.black, // Label color
        ),
      ),
      focusNode: FocusNode()
        ..addListener(() {
          // Update the fillColor when the field is focused
          (context as Element).markNeedsBuild();
        }),
    );
  }
}
