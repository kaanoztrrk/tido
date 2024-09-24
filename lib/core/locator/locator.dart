import 'package:TiDo/blocs/location_bloc/location_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../blocs/auth_blocs/authentication_bloc/authentication_bloc.dart';
import '../../blocs/auth_blocs/sign_in_bloc/sign_in_bloc.dart';
import '../../blocs/auth_blocs/sign_up_bloc/sign_up_bloc.dart';
import '../../blocs/home_bloc/home_bloc.dart';
import '../../blocs/localization_bloc/localization_bloc.dart';
import '../../blocs/main_bloc/main_bloc.dart';
import '../../blocs/theme_bloc/theme_bloc.dart';
import '../../data/repositories/firebase_user_repositories.dart';
import '../../data/repositories/user_repo.dart';
import '../../data/services/google_ads_service.dart';
import '../../data/services/hive_data_service.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerLazySingleton<AuthenticationBloc>(
    () => AuthenticationBloc(
      userRepository: getIt<UserRepository>(),
    ),
  );

  getIt.registerLazySingleton<SignInBloc>(
    () => SignInBloc(
      userRepository: getIt<UserRepository>(),
    ),
  );
  getIt.registerLazySingleton<SignUpBloc>(
    () => SignUpBloc(
      userRepository: getIt<UserRepository>(),
    ),
  );
  getIt.registerLazySingleton<MainBloc>(
    () => MainBloc(pageController: PageController()),
  );

  getIt.registerLazySingleton<LocalizationBloc>(
    () => LocalizationBloc()
      ..add(
        GetLanguage(),
      ),
  );

  getIt.registerLazySingleton<HomeBloc>(() => HomeBloc());

  getIt.registerLazySingleton<ThemeBloc>(() => ThemeBloc());

  getIt.registerLazySingleton<LocationBloc>(() => LocationBloc());

  getIt.registerLazySingleton(() => HiveDataService());

  getIt.registerLazySingleton<GoogleAdsService>(() => GoogleAdsService());

  getIt.registerLazySingleton<UserRepository>(() => FirebaseUserRepo());
}
