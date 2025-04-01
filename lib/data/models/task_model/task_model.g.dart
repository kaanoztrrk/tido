// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskModelAdapter extends TypeAdapter<TaskModel> {
  @override
  final int typeId = 0;

  @override
  TaskModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskModel(
      id: fields[0] as int,
      title: fields[1] as String,
      isChecked: fields[2] as bool,
      taskTime: fields[3] as DateTime?,
      participantImages: (fields[4] as List?)?.cast<String>(),
      files: (fields[5] as List?)?.cast<String>(),
      description: fields[6] as String?,
      categories: (fields[7] as List?)?.cast<CategoryModel>(),
      priority: fields[8] != null && fields[8] is String
          ? fields[8] as String
          : "low",
      links: (fields[9] as List?)?.cast<String>(),
      subtasks: (fields[10] as List?)?.cast<TaskModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, TaskModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.isChecked)
      ..writeByte(3)
      ..write(obj.taskTime)
      ..writeByte(4)
      ..write(obj.participantImages)
      ..writeByte(5)
      ..write(obj.files)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.categories)
      ..writeByte(8)
      ..write(obj.priority)
      ..writeByte(9)
      ..write(obj.links)
      ..writeByte(10)
      ..write(obj.subtasks);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
