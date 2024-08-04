import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tido/core/locator/locator.dart';
import 'package:tido/utils/Theme/theme.dart';

import 'blocs/theme_bloc/theme_bloc.dart';
import 'blocs/theme_bloc/theme_state.dart';
import 'utils/Constant/text_strings.dart';
import 'core/routes/routes_manager.dart';

class TIDO extends StatelessWidget {
  const TIDO({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ThemeBloc>(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          Color primaryColor = state.primaryColor;
          return MaterialApp.router(
            title: ViTexts().appTitle,
            theme: ViAppTheme.getLightTheme(primaryColor),
            darkTheme: ViAppTheme.getDarkTheme(primaryColor),
            themeMode: ThemeMode.system,
            routerConfig: router,
          );
        },
      ),
    );
  }
}
