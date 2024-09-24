import 'package:TiDo/blocs/home_bloc/home_bloc.dart';
import 'package:TiDo/blocs/home_bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      /*
    
      body: BlocBuilder<HomeBloc, HomeState>(
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
     */
    );
  }
}
