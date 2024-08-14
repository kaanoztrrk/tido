import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tido/blocs/auth_blocs/authentication_bloc/authentication_bloc.dart';
import 'package:tido/blocs/localization_bloc/localization_bloc.dart';
import 'package:tido/blocs/localization_bloc/localization_state.dart';
import 'package:tido/core/l10n/l10n.dart';
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
        BlocProvider.value(value: getIt<LocalizationBloc>()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return BlocBuilder<LocalizationBloc, LocalizationState>(
            buildWhen: (previous, current) =>
                previous.selectedLanguage != current.selectedLanguage,
            builder: (context, localizationState) {
              Color primaryColor = themeState.primaryColor;
              Locale currentLocale = localizationState.selectedLanguage.locale;
              return MaterialApp.router(
                locale: currentLocale,
                supportedLocales: AppLocalizations.supportedLocales,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                title: ViTexts().appTitle,
                theme: ViAppTheme.getLightTheme(primaryColor),
                darkTheme: ViAppTheme.getDarkTheme(primaryColor),
                themeMode:
                    themeState.themeMode, // ThemeMode state üzerinden alınır
                routerConfig: router,
              );
            },
          );
        },
      ),
    );
  }
}
