import 'package:hive/hive.dart';

part 'notification_model.g.dart'; // veya doğru part dosyası

@HiveType(typeId: 2) // Burada typeId'yi kontrol edin
class NotificationModel extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String body;

  NotificationModel({
    required this.title,
    required this.body,
  });
}
