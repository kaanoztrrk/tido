import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tido/blocs/home_bloc/home_bloc.dart';
import 'package:tido/blocs/localization_bloc/localization_bloc.dart';
import 'package:tido/blocs/main_bloc/main_bloc.dart';
import 'package:tido/blocs/notification_bloc/notificaiton_bloc.dart';
import 'package:tido/blocs/theme_bloc/theme_bloc.dart';
import 'package:tido/data/services/hive_data_service.dart';
import '../../blocs/auth_blocs/authentication_bloc/authentication_bloc.dart';
import '../../blocs/auth_blocs/sign_in_bloc/sign_in_bloc.dart';
import '../../blocs/auth_blocs/sign_up_bloc/sign_up_bloc.dart';
import '../../data/repositories/firebase_user_repositories.dart';
import '../../data/repositories/user_repo.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerLazySingleton<UserRepository>(() => FirebaseUserRepo());

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

  getIt.registerLazySingleton<HomeBloc>(() => HomeBloc());
  getIt.registerLazySingleton<ThemeBloc>(() => ThemeBloc());
  getIt.registerLazySingleton<NotificationBloc>(() => NotificationBloc());
  getIt.registerLazySingleton(() => HiveDataService());
  getIt.registerLazySingleton<LocalizationBloc>(
      () => LocalizationBloc()..add(GetLanguage()));
}
