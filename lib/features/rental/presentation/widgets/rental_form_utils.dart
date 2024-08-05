import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

Widget buildDateTimePicker(
  BuildContext context,
  String label,
  DateTime? selectedDate,
  Function(DateTime) onDateSelected,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => selectDateTime(context, onDateSelected),
          child: InputDecorator(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedDate != null
                      ? DateFormat('MMM dd, yyyy HH:mm').format(selectedDate)
                      : 'Select date and time',
                ),
                const Icon(Icons.calendar_today),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Future<void> selectDateTime(
    BuildContext context, Function(DateTime) onDateSelected) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(const Duration(days: 365)),
  );

  if (pickedDate != null) {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      final DateTime selectedDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
      onDateSelected(selectedDateTime);
    }
  }
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
