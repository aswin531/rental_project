import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initializeNotifications() async {
  
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}


Future<void> showNotification(int daysLeft) async {
  String notificationTitle;
  String notificationBody;

  if (daysLeft == 1) {
    notificationTitle = "Car Return Reminder";
    notificationBody = "Your car return is due tomorrow.";
  } else if (daysLeft == 0) {
    notificationTitle = "Car Return Due";
    notificationBody = "Your car return is due today.";
  } else {
    notificationTitle = "Car Return Overdue";
    notificationBody = "Your car return is overdue by $daysLeft days.";
  }

  await flutterLocalNotificationsPlugin.show(
    0,
    notificationTitle,
    notificationBody,
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'your_channel_id',
        'your_channel_name',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: true,
      ),
    ),
  );
}
