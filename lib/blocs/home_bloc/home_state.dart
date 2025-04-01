import 'package:TiDo/utils/Constant/image_strings.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../data/models/habit_model/habit_model.dart';
import '../../data/models/task_model/task_model.dart';

class HomeState extends Equatable {
  final int initialIndex;
  final List<TaskModel> allTasksList;
  final List<TaskModel> archiveList;
  final List<TaskModel> filteredTasks;
  final List<HabitModel> habitList;
  final int taskCategoryIndex;
  final TimeOfDay? selectedTime;
  final DateTime? selectedDate;
  final Duration? reminderDuration;
  final List<TaskModel> searchResults;
  final String remainingTime;
  final bool timeFormat;
  final TaskModel? currentTask;

  const HomeState({
    required this.searchResults,
    required this.taskCategoryIndex,
    required this.initialIndex,
    required this.allTasksList,
    required this.archiveList,
    required this.habitList,
    required this.filteredTasks,
    required this.remainingTime,
    required this.selectedTime,
    required this.selectedDate,
    required this.reminderDuration,
    required this.currentTask,
    required this.timeFormat,
  });

  factory HomeState.initial() {
    return HomeState(
      habitList: [],
      timeFormat: false,
      searchResults: [],
      initialIndex: 0,
      taskCategoryIndex: 0,
      allTasksList: [],
      archiveList: [],
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
    List<TaskModel>? allTasksList,
    List<TaskModel>? archiveList,
    List<TaskModel>? filteredTasks,
    List<HabitModel>? habitList,
    TimeOfDay? selectedTime,
    DateTime? selectedDate,
    Duration? reminderDuration,
    List<TaskModel>? searchResults,
    String? remainingTime,
    TaskModel? currentTask,
    bool? timeFormat,
  }) {
    return HomeState(
      initialIndex: initialIndex ?? this.initialIndex,
      taskCategoryIndex: taskCategoryIndex ?? this.taskCategoryIndex,
      allTasksList: allTasksList ?? this.allTasksList,
      archiveList: archiveList ?? this.archiveList,
      habitList: habitList ?? this.habitList,
      filteredTasks: filteredTasks ?? this.filteredTasks,
      selectedTime: selectedTime ?? this.selectedTime,
      selectedDate: selectedDate ?? this.selectedDate,
      reminderDuration: reminderDuration ?? this.reminderDuration,
      searchResults: searchResults ?? this.searchResults,
      remainingTime: remainingTime ?? this.remainingTime,
      currentTask: currentTask ?? this.currentTask,
      timeFormat: timeFormat ?? this.timeFormat,
    );
  }

  int getTaskCount() {
    return allTasksList.length;
  }

  @override
  List<Object?> get props => [
        initialIndex,
        taskCategoryIndex,
        allTasksList,
        filteredTasks,
        selectedTime,
        selectedDate,
        reminderDuration,
        searchResults,
        remainingTime,
        currentTask,
        timeFormat,
      ];
}
