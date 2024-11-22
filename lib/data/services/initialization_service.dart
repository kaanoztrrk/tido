import 'package:TiDo/data/models/habit_model/habit_model.dart';
import 'package:TiDo/firebase_options.dart';
import 'package:TiDo/utils/Constant/app_constants.dart';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:workmanager/workmanager.dart';

import '../models/category_model/category_model.dart';
import '../models/note_model/note_model.dart';
import '../models/notification_model/notification_model.dart';
import '../models/task_model/task_model.dart';
import 'firebase_message_service.dart';
import 'local_notification.dart';
import 'package:timezone/data/latest.dart' as tzData;

void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    print("Task executing: $taskName");

    if (taskName == "backup") {
      // Retrieve the task details from inputData
      final taskId = inputData?['taskId'];
      final taskTitle = inputData?['taskTitle'];

      // Trigger a notification using the LocalNotificationService
      LocalNotificationService notificationService = LocalNotificationService();
      notificationService.showNotification(
        id: taskId,
        title: "Görev Zamanı!",
        body: taskTitle,
      );
    }

    return Future.value(true);
  });
}

class InitializationService {
  static Future<void> initializeApp() async {
    // Gerekli başlangıç işlemleri
    WidgetsFlutterBinding.ensureInitialized();
    MobileAds.instance.initialize();
    tzData.initializeTimeZones();

    Workmanager().initialize(callbackDispatcher);

    // Firebase başlatma
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Hive veritabanı başlatma
    await Hive.initFlutter();
    _registerHiveAdapters();
    await _openHiveBoxes();

    final firebaseMessageService = FirebaseMessageService();
    await firebaseMessageService.initNotifications();

    // OTP ayarları
    await EmailOTP.config(
      appName: 'TiDo',
      otpType: OTPType.numeric,
      emailTheme: EmailTheme.v1,
      appEmail: 'kaanoztrrk411@gmail.com',
      otpLength: 4,
    );

    print('Timezones initialized successfully');
  }

  // Hive Adapter'ları kaydetme
  static void _registerHiveAdapters() {
    Hive.registerAdapter(TaskModelAdapter());
    Hive.registerAdapter(HabitModelAdapter());
    Hive.registerAdapter(CategoryModelAdapter());
    Hive.registerAdapter(NotificationModelAdapter());
    Hive.registerAdapter(NoteModelAdapter());
  }

  static Future<void> _openHiveBoxes() async {
    // Hive kutularını temizleyin (Geliştirme aşamasında kullanılabilir)

    if (!Hive.isBoxOpen(APPContants.categoryBox)) {
      await Hive.openBox<CategoryModel>(APPContants.categoryBox);
    }
    if (!Hive.isBoxOpen(APPContants.taskBox)) {
      await Hive.openBox<TaskModel>(APPContants.taskBox);
    }
    if (!Hive.isBoxOpen(APPContants.noteBox)) {
      await Hive.openBox<NoteModel>(APPContants.noteBox);
    }
    if (!Hive.isBoxOpen(APPContants.notificationsBox)) {
      await Hive.openBox<NotificationModel>(APPContants.notificationsBox);
    }
    if (!Hive.isBoxOpen(APPContants.habitBox)) {
      await Hive.openBox<HabitModel>(APPContants.habitBox);
    }
  }
}
