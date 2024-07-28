import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tido/blocs/auth_blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:tido/blocs/home_bloc/home_bloc.dart';
import 'package:tido/core/locator/locator.dart';
import 'package:tido/utils/Constant/app_constants.dart';

import '../../blocs/auth_blocs/authentication_bloc/authentication_bloc.dart';
import '../../blocs/auth_blocs/authentication_bloc/authentication_state.dart';
import '../../blocs/main_bloc/main_bloc.dart';
import '../../data/repositories/user_repo.dart';
import '../../data/services/shared_preferences_service.dart';
import '../auth/login/login_view.dart';
import '../auth/welcome/welcome_view.dart';
import 'home_navigator.dart';

class MainNavigator extends StatelessWidget {
  final UserRepository userRepository;

  const MainNavigator(this.userRepository, {super.key});

  Future<bool> _isFirstTimeOpening() async {
    final isFirstTime = await SharedPreferencesService.instance
        .getBool(APPContants.isFirstTimeOpening);
    return isFirstTime ?? true;
  }

  Future<void> _setFirstTimeOpening() async {
    await SharedPreferencesService.instance
        .setBool(APPContants.isFirstTimeOpening, false);
  }

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();

    return FutureBuilder<bool>(
      future: _isFirstTimeOpening(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final isFirstTime = snapshot.data ?? true;
        if (isFirstTime) {
          _setFirstTimeOpening();
        }
        return MultiBlocProvider(
          providers: [
            RepositoryProvider<AuthenticationBloc>(
              create: (context) =>
                  AuthenticationBloc(userRepository: userRepository),
            ),
            BlocProvider<MainBloc>(
              create: (context) => MainBloc(pageController),
            ),
          ],
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state.status == AuthenticationStatus.authenticated) {
                return BlocProvider.value(
                  value: getIt<HomeBloc>(),
                  child: const HomeNavigator(),
                );
              } else {
                return isFirstTime
                    ? WelcomeView(pageController: pageController)
                    : BlocProvider.value(
                        value: getIt<SignInBloc>(),
                        child: const LoginView(),
                      );
              }
            },
          ),
        );
      },
    );
  }
}
