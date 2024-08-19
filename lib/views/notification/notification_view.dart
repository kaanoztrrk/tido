import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/notification_bloc/notificaiton_bloc.dart';
import '../../blocs/notification_bloc/notificaiton_state.dart';
import '../../common/widget/appbar/appbar.dart';
import '../../core/l10n/l10n.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ViAppBar(
        showBackArrow: true,
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.notification),
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
