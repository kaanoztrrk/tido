import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tido/data/models/category_model/category_model.dart';
import 'package:tido/data/models/task_model/task_model.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class UpdateTab extends HomeEvent {
  final int index;

  const UpdateTab(this.index);

  @override
  List<Object> get props => [index];
}

class CategoryUpdateTab extends HomeEvent {
  final int index;

  const CategoryUpdateTab(this.index);

  @override
  List<Object> get props => [index];
}

class SwipeCard extends HomeEvent {
  final int index;

  const SwipeCard(this.index);

  @override
  List<Object> get props => [index];
}

class AddCategoryEvent extends HomeEvent {
  final String categoryName;

  const AddCategoryEvent(this.categoryName);

  @override
  List<Object> get props => [categoryName];
}

class TimeSelected extends HomeEvent {
  final TimeOfDay selectedTime;

  const TimeSelected(this.selectedTime);

  @override
  List<Object> get props => [selectedTime];
}

class DateSelected extends HomeEvent {
  final DateTime selectedDate;

  const DateSelected(this.selectedDate);

  @override
  List<Object> get props => [selectedDate];
}

class ReminderSelected extends HomeEvent {
  final Duration reminderDuration;

  const ReminderSelected(this.reminderDuration);

  @override
  List<Object> get props => [reminderDuration];
}

class FilterTasksByDate extends HomeEvent {
  final DateTime date;

  const FilterTasksByDate(this.date);

  @override
  List<Object> get props => [date];
}

class CreateToDoEvent extends HomeEvent {
  final String title;
  final String? description;
  final DateTime? taskTime;
  final List<String>? participantImages;
  final List<String>? files;
  final List<String>? labels;

  const CreateToDoEvent({
    required this.title,
    this.description,
    this.taskTime,
    this.participantImages,
    this.files,
    this.labels,
  });

  @override
  List<Object> get props => [
        title,
        description ?? '',
        taskTime ?? DateTime.now(),
        participantImages ?? [],
        files ?? [],
        labels ?? []
      ];
}

class ChangeCheckBoxEvent extends HomeEvent {
  final bool isChecked;
  final TaskModel task;

  const ChangeCheckBoxEvent({
    required this.isChecked,
    required this.task,
  });

  @override
  List<Object> get props => [isChecked, task];
}

class DeleteToDoEvent extends HomeEvent {
  final TaskModel task;

  const DeleteToDoEvent({required this.task});

  @override
  List<Object> get props => [task];
}

class UpdateToDoEvent extends HomeEvent {
  final TaskModel oldTask;
  final TaskModel newTask;

  const UpdateToDoEvent({
    required this.oldTask,
    required this.newTask,
  });

  @override
  List<Object> get props => [oldTask, newTask];
}

class LoadTasksEvent extends HomeEvent {}

class SearchTasksEvent extends HomeEvent {
  final String query;

  const SearchTasksEvent(this.query);

  @override
  List<Object> get props => [query];
}

class StartTimerEvent extends HomeEvent {}

class UpdateRemainingTimeEvent extends HomeEvent {
  final String remainingTime;

  const UpdateRemainingTimeEvent(this.remainingTime);

  @override
  List<Object> get props => [remainingTime];
}

class DeleteAllTasksEvent extends HomeEvent {}

class DeleteAllCategoryEvent extends HomeEvent {}

class LoadCategoryEvent extends HomeEvent {}

class DeleteCategoryEvent extends HomeEvent {
  final CategoryModel categoryModel;

  const DeleteCategoryEvent({required this.categoryModel});

  @override
  List<Object> get props => [categoryModel];
}

class UpdateCategoryEvent extends HomeEvent {
  final CategoryModel oldCategory;
  final CategoryModel newCategory;

  const UpdateCategoryEvent({
    required this.oldCategory,
    required this.newCategory,
  });

  @override
  List<Object> get props => [oldCategory, newCategory];
}
