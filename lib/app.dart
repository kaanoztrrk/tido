import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tido/blocs/auth_blocs/authentication_bloc/authentication_bloc.dart';
import 'package:tido/core/locator/locator.dart';
import 'package:tido/utils/Theme/theme.dart';

import 'blocs/auth_blocs/sign_in_bloc/sign_in_bloc.dart';
import 'blocs/home_bloc/home_bloc.dart';
import 'blocs/theme_bloc/theme_bloc.dart';
import 'blocs/theme_bloc/theme_state.dart';
import 'utils/Constant/text_strings.dart';
import 'core/routes/routes_manager.dart';

class TIDO extends StatelessWidget {
  const TIDO({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<HomeBloc>()),
        BlocProvider.value(value: getIt<AuthenticationBloc>()),
        BlocProvider.value(value: getIt<SignInBloc>()),
        BlocProvider.value(value: getIt<ThemeBloc>()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          Color primaryColor = state.primaryColor;
          return MaterialApp.router(
            title: ViTexts().appTitle,
            theme: ViAppTheme.getLightTheme(primaryColor),
            darkTheme: ViAppTheme.getDarkTheme(primaryColor),
            themeMode: state.themeMode, // ThemeMode state üzerinden alınır
            routerConfig: router,
          );
        },
      ),
    );
  }
}
