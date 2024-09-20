import 'package:TiDo/blocs/location_bloc/location_bloc.dart';
import 'package:TiDo/views/document/document_view.dart';
import 'package:TiDo/views/note/note_view.dart';
import 'package:TiDo/views/study_technique/pomodoro/pomodoro_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/auth_blocs/authentication_bloc/authentication_bloc.dart';
import '../../blocs/auth_blocs/sign_in_bloc/sign_in_bloc.dart';
import '../../blocs/auth_blocs/sign_up_bloc/sign_up_bloc.dart';
import '../../blocs/home_bloc/home_bloc.dart';
import '../../blocs/notification_bloc/notificaiton_bloc.dart';
import '../../data/models/otp_arguments/otp_arguments_model.dart';
import '../../data/models/task_model/task_model.dart';
import '../../data/repositories/firebase_user_repositories.dart';
import '../../views/auth/change_password/change_password_view.dart';
import '../../views/auth/email_validate/email_validate.dart';
import '../../views/auth/login/login_view.dart';
import '../../views/auth/otp/otp_view.dart';
import '../../views/auth/register/register_view.dart';
import '../../views/auth/forgot_password/forgot_password.dart';

import '../../views/common/splash/splash_view.dart';
import '../../views/auth/welcome/welcome_view.dart';
import '../../views/location_reminder/location_reminder_view.dart';
import '../../views/task/create_task/create_task_view.dart';
import '../../views/folder_detailes.dart/doc_folder_detailes.dart';
import '../../views/folder_detailes.dart/image_folder_detailes.dart';
import '../../views/layout/home_navigator.dart';
import '../../views/layout/main_navigator.dart';
import '../../views/notification/notification_view.dart';
import '../../views/search/search_view.dart';
import '../../views/main_view/settings/customize/theme/theme_view.dart';
import '../../views/main_view/settings/data_security/backup_location_view.dart';
import '../../views/main_view/settings/data_security/data_storage_view.dart';
import '../../views/main_view/settings/profile/profile_view.dart';
import '../../views/main_view/settings/task_category/archive/archive.dart';
import '../../views/main_view/settings/task_category/categories/categories_view.dart';
import '../../views/task/task_detail/task_detail_view.dart';
import '../../views/task/task_edit/task_edit_view.dart';
import '../locator/locator.dart';
import 'routes.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: navigatorKey,
  routes: [
    GoRoute(
      path: ViRoutes.splash_view,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashView();
      },
    ),
    GoRoute(
      path: ViRoutes.welcome_view,
      builder: (BuildContext context, GoRouterState state) {
        return const WelcomeView();
      },
    ),
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
        ], child: const LoginView());
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
          child: ForgotPasswordView(),
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
        final args = state.extra as OtpRouteArguments;

        return BlocProvider.value(
          value: getIt<SignUpBloc>(),
          child: OtpView(userModel: args.userModel, password: args.password),
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
      path: ViRoutes.profile_view,
      builder: (BuildContext context, GoRouterState state) {
        return MultiBlocProvider(providers: [
          BlocProvider.value(value: getIt<HomeBloc>()),
          BlocProvider.value(value: getIt<AuthenticationBloc>()),
          BlocProvider.value(value: getIt<SignInBloc>()),
        ], child: const ProfileView());
      },
    ),
    GoRoute(
      path: ViRoutes.image_folder_detailes,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider.value(
          value: getIt<HomeBloc>(),
          child: const ImageFolderDetailesView(),
        );
      },
    ),
    GoRoute(
      path: ViRoutes.doc_folder_detailes,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider.value(
          value: getIt<HomeBloc>(),
          child: const DocFolderDetailesView(),
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
      path: ViRoutes.data_stroge,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider.value(
          value: getIt<HomeBloc>(),
          child: const DataStorageView(),
        );
      },
    ),
    GoRoute(
      path: ViRoutes.backup_location,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider.value(
          value: getIt<HomeBloc>(),
          child: const BackupLocationView(),
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
        return MultiBlocProvider(providers: [
          BlocProvider.value(value: getIt<HomeBloc>()),
          BlocProvider.value(value: getIt<AuthenticationBloc>()),
          BlocProvider.value(value: getIt<SignInBloc>()),
          BlocProvider.value(value: getIt<NotificationBloc>()),
        ], child: const NotificationView());
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
      path: ViRoutes.archive,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider.value(
          value: getIt<HomeBloc>(),
          child: const ArchiveView(),
        );
      },
    ),
    GoRoute(
      path: ViRoutes.categories,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider.value(
          value: getIt<HomeBloc>(),
          child: const CategoriesView(),
        );
      },
    ),
    GoRoute(
      path: ViRoutes.theme_view,
      builder: (BuildContext context, GoRouterState state) {
        return const ThemeView();
      },
    ),
    GoRoute(
      path: ViRoutes.task_edit_view,
      builder: (BuildContext context, GoRouterState state) {
        final task = state.extra as TaskModel;
        return MultiBlocProvider(providers: [
          BlocProvider.value(value: getIt<HomeBloc>()),
          BlocProvider.value(value: getIt<AuthenticationBloc>()),
          BlocProvider.value(value: getIt<SignInBloc>()),
          BlocProvider.value(value: getIt<NotificationBloc>()),
        ], child: TaskEditView(task: task));
      },
    ),
    GoRoute(
      path: ViRoutes.change_password,
      builder: (BuildContext context, GoRouterState state) {
        return MultiBlocProvider(providers: [
          BlocProvider.value(value: getIt<HomeBloc>()),
          BlocProvider.value(value: getIt<AuthenticationBloc>()),
          BlocProvider.value(value: getIt<SignInBloc>()),
          BlocProvider.value(value: getIt<NotificationBloc>()),
        ], child: const ChangePasswordView());
      },
    ),
    GoRoute(
      path: ViRoutes.document_view,
      builder: (BuildContext context, GoRouterState state) {
        return MultiBlocProvider(providers: [
          BlocProvider.value(value: getIt<HomeBloc>()),
          BlocProvider.value(value: getIt<AuthenticationBloc>()),
          BlocProvider.value(value: getIt<SignInBloc>()),
          BlocProvider.value(value: getIt<NotificationBloc>()),
        ], child: const DocumentView());
      },
    ),
    GoRoute(
      path: ViRoutes.pomodoro_view,
      builder: (BuildContext context, GoRouterState state) {
        return MultiBlocProvider(providers: [
          BlocProvider.value(value: getIt<HomeBloc>()),
        ], child: const PomodoroView());
      },
    ),
    GoRoute(
      path: ViRoutes.location_reminder_view,
      builder: (BuildContext context, GoRouterState state) {
        return MultiBlocProvider(providers: [
          BlocProvider.value(value: getIt<HomeBloc>()),
          BlocProvider.value(value: getIt<LocationBloc>()),
        ], child: const LocationReminderView());
      },
    ),
    GoRoute(
      path: ViRoutes.note_view,
      builder: (BuildContext context, GoRouterState state) {
        return MultiBlocProvider(providers: [
          BlocProvider.value(value: getIt<HomeBloc>()),
        ], child: const NoteView());
      },
    ),
  ],
);
