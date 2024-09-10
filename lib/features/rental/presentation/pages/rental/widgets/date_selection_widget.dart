import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_bloc.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_event.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_state.dart';
import 'package:rentit/utils/appcolors.dart';
import 'package:rentit/utils/primary_text.dart';
import 'package:rentit/widgets/date_picker.dart';
import 'package:rentit/widgets/time_picker.dart';
import 'package:workmanager/workmanager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DateTimeSelectionScreen extends StatelessWidget {
  final String? carId;
  const DateTimeSelectionScreen({super.key, this.carId});

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
              DatePicker(
                title: 'Start Date',
                onDateSelected: (date) {
                  context.read<RentalRequestBloc>().add(
                        UpdateStartDateEvent(pickupDate: date),
                      );
                  _checkAvailability(context);
                },
              ),
              TimePicker(
                title: 'Select Time',
                onTimeSelected: (TimeOfDay time) {
                  final now = DateTime.now();
                  final dateTime = DateTime(
                      now.year, now.month, now.day, time.hour, time.minute);
                  context.read<RentalRequestBloc>().add(
                        UpdateStartTimeEvent(startTime: dateTime),
                      );
                  _checkAvailability(context);
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
                  _checkAvailability(context);
                },
              ),
              TimePicker(
                title: 'Select Time',
                onTimeSelected: (TimeOfDay time) {
                  final now = DateTime.now();
                  final dateTime = DateTime(
                      now.year, now.month, now.day, time.hour, time.minute);
                  context.read<RentalRequestBloc>().add(
                        UpdateReturnTimeEvent(returnTime: dateTime),
                      );
                  _checkAvailability(context);
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _setReminder(context),
            child: const Text('Set Return Reminder'),
          ),
          const SizedBox(height: 10),
          BlocBuilder<RentalRequestBloc, RentalRequestState>(
            builder: (context, state) {
              if (state is CarAvailabilityChecked) {
                return Text(state.isAvailable
                    ? 'Car is available'
                    : 'Car is not available for the selected dates');
              } else if (state is RentalRequestError) {
                return Text('Error: ${state.message}');
              } else if (state is RentalRequestLoading) {
                return const CircularProgressIndicator();
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }

  void _checkAvailability(BuildContext context) {
    final state = context.read<RentalRequestBloc>().state;
    if (state.startDate != null && state.returnDate != null) {
      context.read<RentalRequestBloc>().add(
            CheckCarAvailabilityEvent(
              carId: carId ?? '',
              startDate: state.startDate!,
              endDate: state.returnDate!,
            ),
          );
    }
  }

  Future<void> resetNotificationFlags() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notificationDayBeforeSent', false);
    await prefs.setBool('notificationOnReturnDateSent', false);
    debugPrint('Notification flags reset');
  }

  Future<void> _setReminder(BuildContext context) async {
    final state = context.read<RentalRequestBloc>().state;
    if (state.returnDate != null) {
      // Reset the flags before setting a new reminder
      await resetNotificationFlags();

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('returnDate', state.returnDate!.toIso8601String());

      // Cancel any previously registered tasks
      await Workmanager().cancelByUniqueName('checkReturnDateTask');

      // Register the new task
      await Workmanager().registerPeriodicTask(
        "checkReturnDateTask",
        "Check Return Date Task",
        frequency: const Duration(hours: 24), // Adjust according to your needs
        initialDelay: const Duration(minutes: 1),
        inputData: {'carId': carId},
        constraints: Constraints(
          networkType: NetworkType.not_required,
          requiresBatteryNotLow: true,
        ),
      );

      debugPrint('Reminder set for return date ${state.returnDate}');
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Reminder set for ${state.returnDate!.toString()}'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a return date first')),
      );
    }
  }
}
