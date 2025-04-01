import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  Future<void> sendNotificationToUser(
      String userId, String title, String body) async {
    try {
      String? userToken = await _getUserFcmToken(userId);
      if (userToken != null) {
        await sendNotification(userToken, title, body);
      } else {
        print("User $userId has no FCM token.");
      }
    } catch (e) {
      print("Error sending notification: $e");
    }
  }

  Future<String?> _getUserFcmToken(String userId) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        final data = userDoc.data() as Map<String, dynamic>;
        if (data.containsKey('fcmToken') && data['fcmToken'] is String) {
          return data['fcmToken'];
        }
      }
    } catch (e) {
      print("Error fetching user token: $e");
    }
    return null;
  }

  Future<void> sendNotification(String token, String title, String body) async {
    final privateKeyJson =
        await rootBundle.loadString('assets/tido-firebase.json');
    final Map<String, dynamic> privateKey = json.decode(privateKeyJson);
    final accountCredentials = ServiceAccountCredentials.fromJson(privateKey);
    final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

    final authClient =
        await clientViaServiceAccount(accountCredentials, scopes);

    try {
      final response = await http.post(
        Uri.parse(
            "https://fcm.googleapis.com/v1/projects/tido-678e7/messages:send"),
        body: jsonEncode({
          "message": {
            "token": token,
            "notification": {"title": title, "body": body},
            "data": {
              "click_action": "FLUTTER_NOTIFICATION_CLICK",
              "id": "1",
              "status": "done"
            },
          }
        }),
        headers: {
          'Authorization': 'Bearer ${authClient.credentials.accessToken.data}',
          'Content-Type': 'application/json',
        },
      );
      print(response.body);
    } catch (e) {
      print("Error sending notification: $e");
    }
  }
}
