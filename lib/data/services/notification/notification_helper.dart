import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';
import 'dart:convert';

import '../../models/payload_model/payload_model.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings =
        InitializationSettings(android: androidSettings);

    await _flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        if (notificationResponse.payload != null) {
          print("Notification clicked: ${notificationResponse.payload}");
        }
      },
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showNotification(message);
    });
  }

  static Future<void> showNotification(RemoteMessage message) async {
    try {
      final payload =
          PayloadModel.fromJson(jsonDecode(message.data['payload']));
      const AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
        'channel_id',
        'channel_name',
        importance: Importance.max,
        priority: Priority.high,
      );
      const NotificationDetails details =
          NotificationDetails(android: androidDetails);
      await _flutterLocalNotificationsPlugin.show(
          0, payload.title, payload.body, details);
    } catch (e) {
      print("Error showing notification: $e");
    }
  }

  static Future<void> scheduleNotification(
      DateTime scheduledTime, String title, String body) async {
    Workmanager().registerOneOffTask(
      "scheduled_notification_${scheduledTime.millisecondsSinceEpoch}",
      "show_notification",
      initialDelay: scheduledTime.difference(DateTime.now()),
      inputData: {"title": title, "body": body},
    );
  }
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task.startsWith("scheduled_notification")) {
      final FlutterLocalNotificationsPlugin fln =
          FlutterLocalNotificationsPlugin();
      const AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
        'scheduled_channel',
        'Scheduled Notifications',
        importance: Importance.max,
        priority: Priority.high,
      );
      const NotificationDetails notificationDetails =
          NotificationDetails(android: androidDetails);

      await fln.show(
        0,
        inputData?["title"],
        inputData?["body"],
        notificationDetails,
      );
    }
    return Future.value(true);
  });
}
