import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rentit/utils/appcolors.dart';
import 'package:rentit/utils/primary_text.dart';

class DatePicker extends StatefulWidget {
  final String title;
  final Function(DateTime) onDateSelected;

  const DatePicker({
    super.key,
    required this.title,
    required this.onDateSelected,
  });

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      decoration: BoxDecoration(
          color: ExternalAppColors.bg, borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimaryText(
                  text: "Date",
                  size: 16,
                  color: ExternalAppColors.grey,
                ),
                PrimaryText(
                  text: _selectedDate != null
                      ? DateFormat('d MMM').format(_selectedDate!)
                      : 'Selected Date',
                  color: ExternalAppColors.black,
                  size: 16,
                ),
              ],
            ),
            IconButton(
              color: ExternalAppColors.blue,
              onPressed: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate ?? DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );
                if (date != null) {
                  setState(() {
                    _selectedDate = date;
                  });
                  widget.onDateSelected(date);
                }
              },
              icon: const Icon(
                Icons.calendar_month_outlined,
                size: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
