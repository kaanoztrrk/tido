import 'package:hive/hive.dart';

part 'notification_model.g.dart'; // Dart dosyasının doğru yolu

@HiveType(typeId: 2)
class NotificationModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String body;

  @HiveField(3)
  final DateTime scheduleDateTime;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.scheduleDateTime,
  });
}
