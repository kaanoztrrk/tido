import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../../services/date_formetter_service.dart';
import '../category_model/category_model.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject with EquatableMixin {
  @HiveField(0)
  late int id; // id'yi int olarak güncelledik

  @HiveField(1)
  late String title;

  @HiveField(2)
  bool isChecked;

  @HiveField(3)
  DateTime? taskTime;

  @HiveField(4)
  List<String>? participantImages;

  @HiveField(5)
  List<String>? files;

  @HiveField(6)
  String? description;

  @HiveField(7)
  List<CategoryModel> categories; // Kategori listesi

  TaskModel({
    required this.id, // id'yi constructor'da zorunlu hale getirdik
    required this.title,
    this.isChecked = false,
    this.taskTime,
    this.participantImages,
    this.files,
    this.description,
    List<CategoryModel>? categories,
  }) : categories = categories ??
            [
              CategoryModel(name: "All"),
            ]; // Varsayılan olarak "All" kategorisini ekle

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    final taskTime = json['taskTime'] != null
        ? DateFormat('yyyy-MM-ddTHH:mm:ss').parse(json['taskTime'])
        : null;

    return TaskModel(
      id: json['id'] as int, // id'yi int olarak okuduk
      title: json['title'] as String,
      isChecked: json['isChecked'] as bool,
      taskTime: taskTime,
      participantImages: json['participantImages'] != null
          ? List<String>.from(json['participantImages'] as List)
          : null,
      files: json['files'] != null
          ? List<String>.from(json['files'] as List)
          : null,
      description: json['description'] as String?,
      categories: json['categories'] != null
          ? (json['categories'] as List)
              .map((categoryJson) => CategoryModel.fromJson(categoryJson))
              .toList()
          : [
              CategoryModel(name: "All"),
            ], // Varsayılan olarak "All" kategorisini ekle
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id, // id'yi int olarak ekledik
        'title': title,
        'isChecked': isChecked,
        'taskTime': taskTime != null
            ? DateFormat('yyyy-MM-ddTHH:mm:ss').format(taskTime!)
            : null,
        'participantImages': participantImages,
        'files': files,
        'description': description,
        'categories': categories.map((category) => category.toJson()).toList(),
      };

  TaskModel copyWith({
    int? id, // id'yi int olarak güncelledik
    String? title,
    bool? isChecked,
    DateTime? taskTime,
    List<String>? participantImages,
    List<String>? files,
    String? description,
    List<CategoryModel>? categories,
  }) {
    return TaskModel(
      id: id ?? this.id, // id'yi int olarak kullanıyoruz
      title: title ?? this.title,
      isChecked: isChecked ?? this.isChecked,
      taskTime: taskTime ?? this.taskTime,
      participantImages: participantImages ?? this.participantImages,
      files: files ?? this.files,
      description: description ?? this.description,
      categories: categories ?? this.categories,
    );
  }

  String formattedTaskTime(DateFormatterService formatterService) =>
      formatterService.formatTaskTime(taskTime);

  String formattedDate(DateFormatterService formatterService) =>
      formatterService.formatDate(taskTime);

  @override
  List<Object?> get props => [
        id,
        title,
        isChecked,
        taskTime,
        participantImages,
        files,
        description,
        categories,
      ];
}
