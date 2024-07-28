import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject with EquatableMixin {
  @HiveField(0)
  late String id;

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

  TaskModel({
    String? id,
    required this.title,
    this.isChecked = false,
    this.taskTime,
    this.participantImages,
    this.files,
  }) : id = id ?? const Uuid().v4();

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    final taskTime = json['taskTime'] != null
        ? DateFormat('HH:mm').parse(json['taskTime'])
        : null;

    return TaskModel(
      id: json['id'] as String?,
      title: json['title'] as String,
      isChecked: json['isChecked'] as bool,
      taskTime: taskTime,
      participantImages: json['participantImages'] != null
          ? List<String>.from(json['participantImages'] as List)
          : null,
      files: json['files'] != null
          ? List<String>.from(json['files'] as List)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'isChecked': isChecked,
        'taskTime':
            taskTime != null ? DateFormat('HH:mm').format(taskTime!) : null,
        'participantImages': participantImages,
        'files': files,
      };

  TaskModel copyWith({
    String? id,
    String? title,
    bool? isChecked,
    DateTime? taskTime,
    List<String>? participantImages,
    List<String>? files,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isChecked: isChecked ?? this.isChecked,
      taskTime: taskTime ?? this.taskTime,
      participantImages: participantImages ?? this.participantImages,
      files: files ?? this.files,
    );
  }

  String get formattedTaskTime =>
      taskTime != null ? DateFormat('HH:mm').format(taskTime!) : '';

  @override
  List<Object?> get props => [
        id,
        title,
        isChecked,
        taskTime,
        participantImages,
        files,
      ];
}
