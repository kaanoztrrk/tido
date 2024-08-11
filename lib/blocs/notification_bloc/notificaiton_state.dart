import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationState extends Equatable {
  final List<RemoteMessage> notifications;

  const NotificationState({required this.notifications});

  factory NotificationState.initial() {
    return NotificationState(notifications: []);
  }

  NotificationState copyWith({List<RemoteMessage>? notifications}) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
    );
  }

  @override
  List<Object> get props => [notifications];
}
