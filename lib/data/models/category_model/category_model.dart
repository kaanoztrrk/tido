import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../task_model/task_model.dart';

part 'category_model.g.dart';

@HiveType(typeId: 1)
class CategoryModel extends HiveObject with EquatableMixin {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;

  CategoryModel({
    String? id,
    required this.name,
  }) : id = id ?? const Uuid().v4();

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String?,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  CategoryModel copyWith({
    String? id,
    String? name,
    List<TaskModel>? taskList,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [id, name];
}
