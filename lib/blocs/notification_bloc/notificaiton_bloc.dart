import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../data/services/local_notification.dart';
import 'notificaiton_event.dart';
import 'notificaiton_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationState.initial()) {
    on<AddNotificationEvent>(_onAddNotification);
  }

  Future<void> _onAddNotification(
      AddNotificationEvent event, Emitter<NotificationState> emit) async {
    // Bildirimi LocalNotificationService ile göster
    await LocalNotificationService.showNotification(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000, // Benzersiz bir id
      title: event.message.notification?.title ?? 'Yeni Bildirim',
      body: event.message.notification?.body ?? '',
    );

    // Bildirimi bloc state'ine ekle
    final List<RemoteMessage> updatedNotifications =
        List.from(state.notifications);
    updatedNotifications.add(event.message);

    emit(state.copyWith(notifications: updatedNotifications));
  }
}
