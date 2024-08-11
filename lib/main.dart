import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:email_otp/email_otp.dart';
import 'package:tido/app.dart';
import 'package:tido/data/models/notification_model/notification_model.dart';
import 'package:tido/data/services/firebase_message_service.dart';
import 'core/locator/locator.dart';
import 'data/models/category_model/category_model.dart';
import 'data/models/task_model/task_model.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();

  Hive.registerAdapter(TaskModelAdapter());
  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(NotificationModelAdapter());

  await Hive.openBox<TaskModel>('allTasksBox');
  await Hive.openBox<CategoryModel>('allCategoryBox');
  await Hive.openBox<NotificationModel>('notifications');

  final firebaseMessageService = FirebaseMessageService();
  await firebaseMessageService.initNotifications();

  await setupLocator();

  await EmailOTP.config(
    appName: 'TiDo',
    otpType: OTPType.numeric,
    emailTheme: EmailTheme.v1,
    appEmail: 'kaanoztrrk411@gmail.com',
    otpLength: 4,
  );

  runApp(const TIDO());
}
