import 'package:flutter/material.dart';

Widget buildTextField({
  required TextEditingController controller,
  required String labelText,
  String? Function(String?)? validator,
  TextInputType? keyboardType,
  int maxLines = 1,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines,
    ),
  );
}
Widget buildRadioButton(
    String label, bool value, Function(bool?) onChanged) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Text(label),
        Radio<bool>(
          value: true,
          groupValue: value,
          onChanged: onChanged,
        ),
        const Text('Yes'),
        Radio<bool>(
          value: false,
          groupValue: value,
          onChanged: onChanged,
        ),
        const Text('No'),
      ],
    ),
  );
}
