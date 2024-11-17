import 'package:TiDo/utils/Constant/image_strings.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../data/models/habit_model/habit_model.dart';
import '../../data/models/task_model/task_model.dart';

class HomeState extends Equatable {
  final int initialIndex;
  final List<TaskModel> allTasksList;
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
      habitList: [
        HabitModel(
            id: 0,
            title: "Pomodoro Technique",
            image: ViImages.pomodoro,
            habitType: "pomodoro"),
        HabitModel(
            id: 1,
            title: "Drink Water",
            description: "Drink At Least 8 Glasses of Water Every Day",
            image: ViImages.water,
            habitType: "drink_water"),
        HabitModel(
            id: 2,
            title: "Daily Exercise",
            description: "Exercise for 20-30 Minutes to Stay Active",
            image: ViImages.exercise,
            habitType: "daily_exercise"),
        HabitModel(
            id: 3,
            title: "Daily Meditate",
            description: "Take 5-10 Minutes to Meditate and Clear Your Mind",
            image: ViImages.mediatate,
            habitType: "daily_meditate"),
      ],
      timeFormat: false,
      searchResults: [],
      initialIndex: 0,
      taskCategoryIndex: 0,
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
    List<TaskModel>? allTasksList,
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
