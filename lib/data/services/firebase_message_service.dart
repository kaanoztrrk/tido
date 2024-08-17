// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tido/core/routes/routes_manager.dart';

import '../../core/routes/routes.dart';

class FirebaseMessageService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  FirebaseMessageService();

  Future<void> initNotifications() async {
    // Request permission for iOS
    await _firebaseMessaging.requestPermission();

    // Get FCM token and print it
    final FCMToken = await _firebaseMessaging.getToken();
    print("FCM Token: $FCMToken");

    // Initialize push notifications
    await initPushNotifications();
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    // Print the message details to the terminal
    print("New notification received:");
    print("Title: ${message.notification?.title}");
    print("Body: ${message.notification?.body}");
    print("Data: ${message.data}");

    // Navigate to the notification page
    navigatorKey.currentState?.pushNamed(
      ViRoutes.notification_page,
      arguments: message,
    );
  }

  Future<void> initPushNotifications() async {
    // Handle messages when the app is launched from a terminated state
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    // Handle messages when the app is in the background or terminated
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      handleMessage(message);
    });

    // Handle messages when the user taps on a notification
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}
