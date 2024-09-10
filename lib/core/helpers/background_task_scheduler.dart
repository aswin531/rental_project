import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'notification_helper.dart';
import 'package:workmanager/workmanager.dart';

Future<void> callbackDispatcher() async {
  Workmanager().executeTask((task, inputData) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final returnDateString = prefs.getString('returnDate');
      
      if (returnDateString == null) return Future.value(false);

      final returnDate = DateTime.parse(returnDateString);
      final now = DateTime.now();

      final bool notificationDayBeforeSent = prefs.getBool('notificationDayBeforeSent') ?? false;
      final bool notificationOnReturnDateSent = prefs.getBool('notificationOnReturnDateSent') ?? false;

      // Notify a day before the return date
      if (now.isAfter(returnDate.subtract(const Duration(days: 1))) &&
          now.isBefore(returnDate) &&
          !notificationDayBeforeSent) {
        await showNotification(1); // Notify "due tomorrow"
        prefs.setBool('notificationDayBeforeSent', true);
      }

      // Notify on the return date
      if (now.isAfter(returnDate) &&
          now.difference(returnDate).inDays == 0 &&
          !notificationOnReturnDateSent) {
        await showNotification(0); // Notify "due today"
        prefs.setBool('notificationOnReturnDateSent', true);
      }

      // If overdue by more than 7 days, cancel task
      else if (now.isAfter(returnDate.add(const Duration(days: 7)))) {
        await Workmanager().cancelByUniqueName("checkReturnDateTask");
      }

      return Future.value(true);
    } catch (e) {
      print('Error in background task: $e');
      return Future.value(false);
    }
  });
}


Future<void> scheduleBackgroundTask(DateTime returnDate) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('returnDate', returnDate.toIso8601String());

    await Workmanager().registerPeriodicTask(
      "checkReturnDateTask",
      "Check Return Date Task",
      frequency: const Duration(minutes: 5),//hours: 24
      initialDelay: const Duration(minutes: 1),
      constraints: Constraints(
        networkType: NetworkType.not_required,
        requiresBatteryNotLow: true,
      ),
    );
    debugPrint('Background task scheduled successfully');
  } catch (e) {
    debugPrint('Error scheduling backgro  und task: $e');
  }
}
