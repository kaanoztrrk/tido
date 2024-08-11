import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'notificaiton_event.dart';
import 'notificaiton_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationState.initial()) {
    on<AddNotificationEvent>(_onAddNotification);
  }

  void _onAddNotification(
      AddNotificationEvent event, Emitter<NotificationState> emit) {
    final List<RemoteMessage> updatedNotifications =
        List.from(state.notifications);
    updatedNotifications.add(event.message);

    emit(state.copyWith(notifications: updatedNotifications));
  }
}
