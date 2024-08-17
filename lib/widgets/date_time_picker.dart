import 'package:flutter/material.dart';
import 'package:rentit/utils/primary_text.dart';

class DateTimePickerWidget extends StatelessWidget {
  final String title;
  final Function(DateTime) onDateTimeSelected;
  const DateTimePickerWidget(
      {super.key, required this.title, required this.onDateTimeSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryText(
          text: title,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 8),
        IconButton(
            onPressed: () async {
              final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100));
              if (date != null) {
                final time = await showTimePicker(
                    // ignore: use_build_context_synchronously
                    context: context, initialTime: TimeOfDay.now());

                if (time != null) {
                  final dateTime = DateTime(
                      date.year, date.month, date.day, time.hour, time.minute);
                  onDateTimeSelected(dateTime);
                }
              }
            },
            icon: const Icon(Icons.calendar_month_outlined))
      ],
    );
  }
}
