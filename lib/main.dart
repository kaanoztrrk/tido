import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tido/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/locator/locator.dart';
import 'data/models/category_model/category_model.dart';
import 'data/models/task_model/task_model.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await setupLocator();

  await Hive.initFlutter();

  Hive.registerAdapter(TaskModelAdapter());
  Hive.registerAdapter(CategoryModelAdapter());

  await Hive.openBox<TaskModel>('allTasksBox');
  await Hive.openBox<CategoryModel>('allCategoryBox');

  await EmailOTP.config(
    appName: 'TiDo',
    otpType: OTPType.numeric,
    emailTheme: EmailTheme.v1,
    appEmail: 'kaanoztrrk411@gmail.com',
    otpLength: 4,
  );

  runApp(const TIDO());
}
