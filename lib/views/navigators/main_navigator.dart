import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tido/blocs/auth_blocs/authentication_bloc/authentication_bloc.dart';
import 'package:tido/blocs/main_bloc/main_bloc.dart';
import 'package:tido/core/locator/locator.dart';
import 'package:tido/data/repositories/user_repo.dart';
import 'package:tido/data/services/shared_preferences_service.dart';
import 'package:tido/utils/Constant/app_constants.dart';
import '../../blocs/auth_blocs/authentication_bloc/authentication_state.dart';
import '../../blocs/home_bloc/home_bloc.dart';
import '../auth/login/login_view.dart';
import '../auth/welcome/welcome_view.dart';
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
