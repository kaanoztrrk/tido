import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth_blocs/authentication_bloc/authentication_bloc.dart';
import '../../blocs/auth_blocs/authentication_bloc/authentication_state.dart';

import '../../blocs/main_bloc/main_bloc.dart';
import '../../core/locator/locator.dart';
import '../../data/repositories/user_repo.dart';
import '../auth/login/login_view.dart';

import 'home_navigator.dart';

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
            return const HomeNavigator();
          } else {
            return const LoginView();
          }
        },
      ),
    );
  }
}
