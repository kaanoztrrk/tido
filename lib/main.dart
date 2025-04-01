import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'core/locator/locator.dart';
import 'data/services/initialization_service.dart';
import 'data/services/study_technique/pomodoro_service.dart';

void main() async {
  await InitializationService.initializeApp();

  // Dependency Injection
  await setupLocator();

  runApp(
    MultiBlocProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PomodoroService(),
        ),
      ],
      child: const TIDO(),
    ),
  );
}
