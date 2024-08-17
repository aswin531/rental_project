import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_bloc.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_event.dart';
import 'package:rentit/widgets/date_time_picker.dart';

class DateTimeSelectionScreenWidget extends StatelessWidget {
  const DateTimeSelectionScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DateTimePickerWidget(
            title: 'Start Date & Time',
            onDateTimeSelected: (dateTime) {
              // context
              //     .read<RentalRequestBloc>()
              //     .add(UpdateStartDateTimeEvent(startDateTime: dateTime));
            }),
        
      ],
    );
  }
}
