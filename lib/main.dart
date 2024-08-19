import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:email_otp/email_otp.dart';
import 'app.dart';
import 'core/locator/locator.dart';
import 'data/models/category_model/category_model.dart';
import 'data/models/notification_model/notification_model.dart';
import 'data/models/task_model/task_model.dart';
import 'data/services/firebase_message_service.dart';
import 'data/services/local_notification.dart';
import 'firebase_options.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await LocalNotificationService.initialize();
  tz.initializeTimeZones();
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
