import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class AddNotificationEvent extends NotificationEvent {
  final RemoteMessage message;

  const AddNotificationEvent(this.message);

  @override
  List<Object> get props => [message];
}
