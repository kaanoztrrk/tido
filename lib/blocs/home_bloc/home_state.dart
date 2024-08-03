import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tido/data/models/task_model/task_model.dart';

class HomeState extends Equatable {
  final int initialIndex;
  final List<String> taskCategoryList;
  final List<TaskModel> allTasksList;
  final List<TaskModel> filteredTasks;
  final int taskCategoryIndex;
  final TimeOfDay? selectedTime;
  final DateTime? selectedDate;
  final Duration? reminderDuration;
  final List<TaskModel> searchResults;
  final String remainingTime;
  final TaskModel? currentTask;

  const HomeState({
    required this.searchResults,
    required this.taskCategoryList,
    required this.taskCategoryIndex,
    required this.initialIndex,
    required this.allTasksList,
    required this.filteredTasks,
    required this.remainingTime,
    required this.selectedTime,
    required this.selectedDate,
    required this.reminderDuration,
    required this.currentTask,
  });

  factory HomeState.initial() {
    return const HomeState(
      searchResults: [],
      initialIndex: 0,
      taskCategoryIndex: 0,
      taskCategoryList: ["All"],
      allTasksList: [],
      filteredTasks: [],
      selectedTime: null,
      selectedDate: null,
      reminderDuration: null,
      remainingTime: "",
      currentTask: null,
    );
  }

  HomeState copyWith({
    int? initialIndex,
    int? taskCategoryIndex,
    List<String>? taskCategoryList,
    List<TaskModel>? allTasksList,
    List<TaskModel>? filteredTasks,
    TimeOfDay? selectedTime,
    DateTime? selectedDate,
    Duration? reminderDuration,
    List<TaskModel>? searchResults,
    String? remainingTime,
    TaskModel? currentTask,
  }) {
    return HomeState(
      initialIndex: initialIndex ?? this.initialIndex,
      taskCategoryIndex: taskCategoryIndex ?? this.taskCategoryIndex,
      taskCategoryList: taskCategoryList ?? this.taskCategoryList,
      allTasksList: allTasksList ?? this.allTasksList,
      filteredTasks: filteredTasks ?? this.filteredTasks,
      selectedTime: selectedTime ?? this.selectedTime,
      selectedDate: selectedDate ?? this.selectedDate,
      reminderDuration: reminderDuration ?? this.reminderDuration,
      searchResults: searchResults ?? this.searchResults,
      remainingTime: remainingTime ?? this.remainingTime,
      currentTask: currentTask ?? this.currentTask,
    );
  }

  int getTaskCount(int index) {
    return allTasksList.length;
  }

  @override
  List<Object?> get props => [
        initialIndex,
        taskCategoryList,
        taskCategoryIndex,
        allTasksList,
        filteredTasks,
        selectedTime,
        selectedDate,
        reminderDuration,
        searchResults,
        remainingTime,
        currentTask,
      ];
}
