import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rentit/utils/appcolors.dart';
import 'package:rentit/utils/primary_text.dart';

class TimePicker extends StatefulWidget {
  final String title;
  final Function(TimeOfDay) onTimeSelected;

  const TimePicker({
    super.key,
    required this.title,
    required this.onTimeSelected,
  });

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      decoration: BoxDecoration(
          color: ExternalAppColors.bg, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrimaryText(
              text: _selectedTime != null
                  ? _selectedTime!.format(context)
                  : widget.title,
              size: 16,
              color: ExternalAppColors.black,
            ),
            IconButton(
              color: ExternalAppColors.blue,
              onPressed: () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: _selectedTime ?? TimeOfDay.now(),
                );
                if (time != null) {
                  setState(() {
                    _selectedTime = time;
                  });
                  widget.onTimeSelected(time);
                }
              },
              icon: const Icon(FontAwesomeIcons.clock),
            ),
          ],
        ),
      ),
    );
  }
}
