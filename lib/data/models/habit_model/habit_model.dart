import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

part 'habit_model.g.dart';

@HiveType(typeId: 4) // Farklı bir typeId kullanıyoruz
class HabitModel extends HiveObject with EquatableMixin {
  @HiveField(0)
  late int id; // Her alışkanlık için benzersiz bir ID

  @HiveField(1)
  late String title; // Alışkanlığın adı

  @HiveField(2)
  bool isCompleted; // Alışkanlık o gün tamamlandı mı?

  @HiveField(3)
  String habitType; // Örneğin: Sağlık, Fitness, Gelişim

  @HiveField(4)
  int frequency; // Günlük sıklık (örneğin: 1 kez yapılmalı)

  @HiveField(5)
  DateTime? startDate; // Alışkanlığın başlangıç tarihi

  @HiveField(6)
  DateTime? endDate; // Alışkanlığın bitiş tarihi

  @HiveField(7)
  String? description; // Alışkanlıkla ilgili açıklama

  @HiveField(8)
  String? image; // Alışkanlıkla ilgili bir resim URL'si veya base64 verisi

  @HiveField(9)
  int streak; // Art arda gün sayısı

  @HiveField(10)
  double completionPercentage; // Tamamlanma yüzdesi (0.0 - 1.0)

  HabitModel({
    required this.id,
    required this.title,
    this.isCompleted = false,
    required this.habitType,
    this.frequency = 1, // Varsayılan olarak günde 1 kez yapılmalı
    this.startDate,
    this.endDate,
    this.description,
    this.image,
    this.streak = 0, // Varsayılan olarak sıfır
    this.completionPercentage = 0.0, // Varsayılan olarak sıfır
  });

  factory HabitModel.fromJson(Map<String, dynamic> json) {
    final startDate = json['startDate'] != null
        ? DateFormat('yyyy-MM-ddTHH:mm:ss').parse(json['startDate'])
        : null;
    final endDate = json['endDate'] != null
        ? DateFormat('yyyy-MM-ddTHH:mm:ss').parse(json['endDate'])
        : null;

    return HabitModel(
      id: json['id'] as int,
      title: json['title'] as String,
      isCompleted: json['isCompleted'] as bool,
      habitType: json['habitType'] as String,
      frequency: json['frequency'] as int,
      startDate: startDate,
      endDate: endDate,
      description: json['description'] as String?,
      image: json['image'] as String?,
      streak: json['streak'] as int? ?? 0,
      completionPercentage: json['completionPercentage'] as double? ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'isCompleted': isCompleted,
        'habitType': habitType,
        'frequency': frequency,
        'startDate': startDate != null
            ? DateFormat('yyyy-MM-ddTHH:mm:ss').format(startDate!)
            : null,
        'endDate': endDate != null
            ? DateFormat('yyyy-MM-ddTHH:mm:ss').format(endDate!)
            : null,
        'description': description,
        'image': image,
        'streak': streak,
        'completionPercentage': completionPercentage,
      };

  HabitModel copyWith({
    int? id,
    String? title,
    bool? isCompleted,
    String? habitType,
    int? frequency,
    DateTime? startDate,
    DateTime? endDate,
    String? description,
    String? image,
    int? streak,
    double? completionPercentage,
  }) {
    return HabitModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      habitType: habitType ?? this.habitType,
      frequency: frequency ?? this.frequency,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      description: description ?? this.description,
      image: image ?? this.image,
      streak: streak ?? this.streak,
      completionPercentage: completionPercentage ?? this.completionPercentage,
    );
  }

  void updateCompletionPercentage(DateTime today) {
    if (startDate == null || endDate == null || today.isBefore(startDate!)) {
      completionPercentage = 0.0;
      return;
    }

    final totalDays = endDate!.difference(startDate!).inDays + 1;
    final daysPassed = today.difference(startDate!).inDays + 1;
    final completedDays = (daysPassed > totalDays) ? totalDays : daysPassed;

    completionPercentage = completedDays / totalDays;
  }

  void updateStreak(bool completedToday) {
    if (completedToday) {
      streak += 1;
    } else {
      streak = 0;
    }
  }

  @override
  List<Object?> get props => [
        id,
        title,
        isCompleted,
        habitType,
        frequency,
        startDate,
        endDate,
        description,
        image,
        streak,
        completionPercentage,
      ];
}
