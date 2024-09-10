// ignore_for_file: depend_on_referenced_packages, library_prefixes

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzData;

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  // Initialize the notification settings
  static Future<void> initialize() async {
    const AndroidInitializationSettings androidInitialize =
        AndroidInitializationSettings('mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitialize);

    await _notifications.initialize(initializationSettings);
    // Initialize the timezone data
    tzData.initializeTimeZones();
  }

  // Define notification details
  static Future<NotificationDetails> _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        "TiDo",
        "Task",
        channelDescription: "Channel for Task Notifications",
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        enableVibration: true,
      ),
    );
  }

  // Show a notification immediately
  static Future<void> showNotification({
    int id = 0,
    required String title,
    required String body,
  }) async {
    await _notifications.show(
      id,
      title,
      body,
      await _notificationDetails(),
    );
  }

  // Schedule a notification at a specific time
  static Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduleDateTime,
  }) async {
    // Ensure the timezone data is initialized
    tzData.initializeTimeZones();

    // Convert the DateTime to a TZDateTime object
    final tz.TZDateTime scheduledDateTime =
        tz.TZDateTime.from(scheduleDateTime, tz.local);

    await _notifications.zonedSchedule(
      id,
      title,
      body,
      scheduledDateTime,
      await _notificationDetails(),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      // Add a time zone if needed
      // androidAllowWhileIdle: true, // Optional: allows notification to be shown when the device is idle
    );
  }

  // Cancel all notifications
  static Future<void> unScheduleAllNotifications() async =>
      await _notifications.cancelAll();
}
