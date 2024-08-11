import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/notification_bloc/notificaiton_bloc.dart';
import '../../blocs/notification_bloc/notificaiton_state.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key, this.message});

  final RemoteMessage? message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.notifications.length,
            itemBuilder: (context, index) {
              final message = state.notifications[index];
              return ListTile(
                leading:
                    Icon(Icons.message, color: Theme.of(context).primaryColor),
                title: Text(message.notification?.title ?? "No Title"),
                subtitle: Text(message.notification?.body ?? "No Body"),
              );
            },
          );
        },
      ),
    );
  }
}
