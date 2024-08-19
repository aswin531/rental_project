import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_bloc.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_event.dart';
import 'package:rentit/utils/appcolors.dart';
import 'package:rentit/utils/primary_text.dart';
import 'package:rentit/widgets/date_picker.dart';
import 'package:rentit/widgets/time_picker.dart';

class DateTimeSelectionScreen extends StatelessWidget {
  const DateTimeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          PrimaryText(
            text: "Pick-Up Date & Time",
            size: 20,
            color: ExternalAppColors.black,
          ),
          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  DatePicker(
                    title: 'Start Date',
                    onDateSelected: (date) {
                      context.read<RentalRequestBloc>().add(
                            UpdateStartDateEvent(startDate: date),
                          );
                    },
                  ),
                ],
              ),
              TimePicker(
                title: 'Return Time',
                onTimeSelected: (TimeOfDay time) {
                  final now = DateTime.now();
                  final dateTime = DateTime(
                      now.year, now.month, now.day, time.hour, time.minute);
                  context.read<RentalRequestBloc>().add(
                        UpdateReturnTimeEvent(returnTime: dateTime),
                      );
                },
              ),
            ],
          ),
          const SizedBox(height: 20),

          PrimaryText(
            text: "Return Date & Time",
            size: 20,
            color: ExternalAppColors.black,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DatePicker(
                title: 'Return Date',
                onDateSelected: (date) {
                  context.read<RentalRequestBloc>().add(
                        UpdateReturnDateEvent(returnDate: date),
                      );
                },
              ),
              TimePicker(
                title: 'Return Time',
                onTimeSelected: (TimeOfDay time) {
                  final now = DateTime.now();
                  final dateTime = DateTime(
                      now.year, now.month, now.day, time.hour, time.minute);
                  // debugPrint(dateTime.toString);
                  context.read<RentalRequestBloc>().add(
                        UpdateReturnTimeEvent(returnTime: dateTime),
                      );
                },
              ),
            ],
          ),

          const SizedBox(height: 40),
          // Next Button
          // ElevatedButton(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => RentalFormScreen(),
          //       ),
          //     );
          //   },
          //   child: const Text('Next'),
          // ),
        ],
      ),
    );
  }
}
