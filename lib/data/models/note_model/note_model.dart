import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'note_model.g.dart';

@HiveType(typeId: 3)
class NoteModel extends HiveObject with EquatableMixin {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  String? content;

  @HiveField(3)
  DateTime? createdAt;

  @HiveField(4)
  List<String>? labels;

  NoteModel({
    String? id,
    required this.title,
    this.content,
    DateTime? createdAt,
    this.labels,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ??
            DateTime.now(); // Varsayılan olarak DateTime.now() atanıyor

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    final createdAt = json['createdAt'] != null
        ? DateTime.parse(json['createdAt'] as String)
        : null;

    return NoteModel(
      id: json['id'] as String?,
      title: json['title'] as String,
      content: json['content'] as String?,
      createdAt: createdAt,
      labels: json['labels'] != null
          ? List<String>.from(json['labels'] as List)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'createdAt': createdAt?.toIso8601String(),
        'labels': labels,
      };

  NoteModel copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? createdAt,
    List<String>? labels,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      labels: labels ?? this.labels,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        createdAt,
        labels,
      ];
}
