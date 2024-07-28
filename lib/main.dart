import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tido/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/locator/locator.dart';
import 'data/models/task_model/task_model.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase initialization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Setup locator
  await setupLocator();

  // Hive initialization
  await Hive.initFlutter();

  // Registering the adapter
  Hive.registerAdapter(TaskModelAdapter());

  // Opening the Hive box
  await Hive.openBox<TaskModel>('allTasksBox');

  EmailOTP.config(
    appName: 'TiDo',
    otpType: OTPType.numeric,
    emailTheme: EmailTheme.v1,
    appEmail: 'kaanoztrrk411@gmail.com',
    otpLength: 4,
  );

  runApp(const TIDO());
}
