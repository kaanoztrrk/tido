import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tido/data/models/task_model/task_model.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class UpdateTab extends HomeEvent {
  final int index;

  const UpdateTab(this.index);
}

class CategoryUpdateTab extends HomeEvent {
  final int index;

  const CategoryUpdateTab(this.index);
}

class SwipeCard extends HomeEvent {
  final int index;

  const SwipeCard(this.index);
}

class AddCategory extends HomeEvent {
  final String categoryName;

  const AddCategory(this.categoryName);
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
}

class FilterTasksByDate extends HomeEvent {
  final DateTime date;

  const FilterTasksByDate(this.date);

  @override
  List<Object> get props => [date];
}

class CreateToDoEvent extends HomeEvent {
  final String title;
  final DateTime? taskTime;
  final List<String>? participantImages;
  final List<String>? files;
  final String generalType;
  final String specificType;

  const CreateToDoEvent({
    required this.title,
    this.taskTime,
    this.participantImages,
    this.files,
    this.generalType = 'general',
    this.specificType = 'general',
  });
}

class ChangeCheckBoxEvent extends HomeEvent {
  final bool isChecked;
  final TaskModel task;

  const ChangeCheckBoxEvent({
    required this.isChecked,
    required this.task,
  });
}

class DeleteToDoEvent extends HomeEvent {
  final TaskModel task;

  const DeleteToDoEvent({required this.task});
}

class UpdateToDoEvent extends HomeEvent {
  final TaskModel oldTask;
  final TaskModel newTask;

  const UpdateToDoEvent({
    required this.oldTask,
    required this.newTask,
  });
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
}

class DeleteAllTasksEvent extends HomeEvent {}

class AddCategoryEvent extends HomeEvent {
  final String categoryName;

  const AddCategoryEvent(this.categoryName);

  @override
  List<Object> get props => [categoryName];
}

class RemoveCategoryEvent extends HomeEvent {
  final String categoryName;

  const RemoveCategoryEvent(this.categoryName);

  @override
  List<Object> get props => [categoryName];
}

class UpdateCategoryEvent extends Equatable {
  final String oldCategoryName;
  final String newCategoryName;

  const UpdateCategoryEvent({
    required this.oldCategoryName,
    required this.newCategoryName,
  });

  @override
  List<Object?> get props => [oldCategoryName, newCategoryName];
}
