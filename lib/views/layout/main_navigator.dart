import 'package:TiDo/views/layout/tablet_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth_blocs/authentication_bloc/authentication_bloc.dart';
import '../../blocs/auth_blocs/authentication_bloc/authentication_state.dart';

import '../../blocs/main_bloc/main_bloc.dart';
import '../../core/locator/locator.dart';
import '../../data/repositories/user_repo.dart';
import '../mobile/auth/login/login_view.dart';

import 'mobile_navigator.dart';

class MainNavigator extends StatelessWidget {
  final UserRepository userRepository;

  const MainNavigator(this.userRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider<AuthenticationBloc>(
          create: (context) =>
              AuthenticationBloc(userRepository: userRepository),
        ),
        BlocProvider.value(
          value: getIt<MainBloc>(),
        ),
      ],
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            return LayoutBuilder(
              builder: (context, constraints) {
                bool isTablet = constraints.maxWidth > 600;
                return isTablet
                    ? const TabletNavigator()
                    : const MobileNavigator();
              },
            );
          } else {
            return const LoginView();
          }
        },
      ),
    );
  }
}
