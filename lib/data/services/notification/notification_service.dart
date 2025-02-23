import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  Future<void> sendNotificationToAllUsers(String title, String body) async {
    try {
      await sendNotification(title, body);
    } catch (e) {
      print("Error sending notification: $e");
    }
  }

  @Deprecated('Kullanım dışı artık kullanılmayacak.')
  Future<List<String>> _getAllUserTokens() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot snapshot = await firestore.collection('users').get();

      List<String> tokens = [];
      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;

        if (data.containsKey('fcmToken') &&
            data['fcmToken'] is String &&
            data['fcmToken'].isNotEmpty) {
          tokens.add(data['fcmToken']); // Doğrudan string'i listeye ekle
        } else {
          print("No fcmToken field found in document: ${doc.id}");
        }
      }

      return tokens;
    } catch (e) {
      print("Error fetching user tokens: $e");
      return [];
    }
  }

  sendNotification(String title, String body) async {
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
            "topic": "public",
            "notification": {"body": body, "title": title},
            "data": {
              "click_action": "FLUTTER_NOTIFICATION_CLICK",
              "id": "1",
              "status": "done"
            },
          }
        }),
        headers: {
          'Authorization': 'Bearer ${authClient.credentials.accessToken.data}'
        },
      );
      print(response.body);
    } catch (e) {
      print(e);
    }
  }
}
