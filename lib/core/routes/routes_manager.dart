import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tido/blocs/auth_blocs/authentication_bloc/authentication_bloc.dart';
import 'package:tido/blocs/auth_blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:tido/blocs/auth_blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:tido/blocs/home_bloc/home_bloc.dart';
import 'package:tido/core/locator/locator.dart';
import 'package:tido/core/routes/routes.dart';
import 'package:tido/data/models/task_model/task_model.dart';
import 'package:tido/views/create_task/create_task_view.dart';
import 'package:tido/views/folder_detailes.dart/doc_folder_detailes.dart';
import 'package:tido/views/navigators/main_navigator.dart';
import 'package:tido/views/auth/login/login_view.dart';
import 'package:tido/views/auth/otp/otp_view.dart';
import 'package:tido/views/navigators/home_navigator.dart';
import 'package:tido/views/notificaition_view/notification_view.dart';
import 'package:tido/views/personalization/customize/theme_view.dart';
import 'package:tido/views/search/search_view.dart';

import '../../data/repositories/firebase_user_repositories.dart';
import '../../views/auth/email_validate/email_validate.dart';
import '../../views/auth/register/register_view.dart';
import '../../views/auth/forgot_password/forgot_password.dart';

import '../../views/folder_detailes.dart/image_folder_detailes.dart';
import '../../views/task_detail/task_detail_view.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: ViRoutes.main,
      builder: (BuildContext context, GoRouterState state) {
        return MainNavigator(FirebaseUserRepo());
      },
    ),
    GoRoute(
      path: ViRoutes.login,
      builder: (BuildContext context, GoRouterState state) {
        return MultiBlocProvider(providers: [
          BlocProvider.value(value: getIt<HomeBloc>()),
          BlocProvider.value(value: getIt<AuthenticationBloc>()),
          BlocProvider.value(value: getIt<SignInBloc>()),
        ], child: LoginView());
      },
    ),
    GoRoute(
      path: ViRoutes.register,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider.value(
          value: getIt<SignUpBloc>(),
          child: const RegisterView(),
        );
      },
    ),
    GoRoute(
      path: ViRoutes.forgot_password,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider.value(
          value: getIt<SignInBloc>(),
          child: const ForgotPasswordView(),
        );
      },
    ),
    GoRoute(
      path: ViRoutes.validate_email,
      builder: (BuildContext context, GoRouterState state) {
        return const ValidateEmailView();
      },
    ),
    GoRoute(
      path: ViRoutes.otp,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider.value(
          value: getIt<SignUpBloc>(),
          child: const OtpView(),
        );
      },
    ),
    GoRoute(
      path: ViRoutes.home,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeNavigator();
      },
    ),
    GoRoute(
      path: ViRoutes.create_task,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider.value(
          value: getIt<HomeBloc>(),
          child: const CreateTaskView(),
        );
      },
    ),
    GoRoute(
      path: ViRoutes.task_detail_view,
      builder: (BuildContext context, GoRouterState state) {
        final task = state.extra as TaskModel;
        return MultiBlocProvider(providers: [
          BlocProvider.value(value: getIt<HomeBloc>()),
          BlocProvider.value(value: getIt<AuthenticationBloc>()),
          BlocProvider.value(value: getIt<SignInBloc>()),
        ], child: TaskDetailView(task: task));
      },
    ),
    GoRoute(
      path: ViRoutes.image_folder_detailes,
      builder: (BuildContext context, GoRouterState state) {
        // `extra` özelliği ile veri alınıyor
        final String title = state.extra as String? ?? 'Default Title';
        return BlocProvider.value(
          value: getIt<HomeBloc>(),
          child: ImageFolderDetailesView(title: title),
        );
      },
    ),
    GoRoute(
      path: ViRoutes.doc_folder_detailes,
      builder: (BuildContext context, GoRouterState state) {
        // `extra` özelliği ile veri alınıyor
        final String title = state.extra as String? ?? 'Default Title';
        return BlocProvider.value(
          value: getIt<HomeBloc>(),
          child: DocFolderDetailesView(title: title),
        );
      },
    ),
    GoRoute(
      path: ViRoutes.edit_page,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider.value(
          value: getIt<HomeBloc>(),
          child: const HomeNavigator(),
        );
      },
    ),
    GoRoute(
      path: ViRoutes.theme_page,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider.value(
          value: getIt<HomeBloc>(),
          child: const HomeNavigator(),
        );
      },
    ),
    GoRoute(
      path: ViRoutes.widget_page,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider.value(
          value: getIt<HomeBloc>(),
          child: const HomeNavigator(),
        );
      },
    ),
    GoRoute(
      path: ViRoutes.language_page,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider.value(
          value: getIt<HomeBloc>(),
          child: const HomeNavigator(),
        );
      },
    ),
    GoRoute(
      path: ViRoutes.notification_reminder,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider.value(
          value: getIt<HomeBloc>(),
          child: const HomeNavigator(),
        );
      },
    ),
    GoRoute(
      path: ViRoutes.task_sorthing_option,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider.value(
          value: getIt<HomeBloc>(),
          child: const HomeNavigator(),
        );
      },
    ),
    GoRoute(
      path: ViRoutes.categories,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider.value(
          value: getIt<HomeBloc>(),
          child: const HomeNavigator(),
        );
      },
    ),
    GoRoute(
      path: ViRoutes.data_stroge,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider.value(
          value: getIt<HomeBloc>(),
          child: const HomeNavigator(),
        );
      },
    ),
    GoRoute(
      path: ViRoutes.backup_location,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider.value(
          value: getIt<HomeBloc>(),
          child: const HomeNavigator(),
        );
      },
    ),
    GoRoute(
      path: ViRoutes.password,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider.value(
          value: getIt<HomeBloc>(),
          child: const HomeNavigator(),
        );
      },
    ),
    GoRoute(
      path: ViRoutes.notification_page,
      builder: (BuildContext context, GoRouterState state) {
        return const NotificationView();
      },
    ),
    GoRoute(
      path: ViRoutes.search_view,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider.value(
          value: getIt<HomeBloc>(),
          child: const SearchView(),
        );
      },
    ),
    GoRoute(
      path: ViRoutes.theme_view,
      builder: (BuildContext context, GoRouterState state) {
        return const ThemeView();
      },
    ),
  ],
);
