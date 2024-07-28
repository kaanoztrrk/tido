import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tido/data/models/task_model/task_model.dart';

class HomeState extends Equatable {
  final int initialIndex;
  final List<String> taskCategoryList;
  final List<TaskModel> allTasksList;
  final List<TaskModel> todayTasksList;
  final List<TaskModel> weeklyTasksList;
  final List<TaskModel> filteredTasks; // Yeni eklenen state
  final int taskCategoryIndex;
  final TimeOfDay? selectedTime;
  final DateTime? selectedDate;
  final Duration? reminderDuration;
  final List<TaskModel> searchResults;

  const HomeState({
    required this.searchResults,
    required this.taskCategoryList,
    required this.taskCategoryIndex,
    required this.initialIndex,
    required this.allTasksList,
    required this.todayTasksList,
    required this.weeklyTasksList,
    required this.filteredTasks, // Yeni eklenen state
    this.selectedTime,
    this.selectedDate,
    this.reminderDuration,
  });

  factory HomeState.initial() {
    return const HomeState(
      searchResults: [],
      initialIndex: 0,
      taskCategoryIndex: 0,
      taskCategoryList: ["All", "Today Tasks", "Weekly Tasks"],
      allTasksList: [],
      todayTasksList: [],
      weeklyTasksList: [],
      filteredTasks: [], // Yeni eklenen state
      selectedTime: null,
      selectedDate: null,
      reminderDuration: null,
    );
  }

  HomeState copyWith({
    int? initialIndex,
    int? taskCategoryIndex,
    List<String>? taskCategoryList,
    List<TaskModel>? allTasksList,
    List<TaskModel>? todayTasksList,
    List<TaskModel>? weeklyTasksList,
    List<TaskModel>? filteredTasks,
    TimeOfDay? selectedTime,
    DateTime? selectedDate,
    Duration? reminderDuration,
    List<TaskModel>? searchResults,
  }) {
    return HomeState(
        initialIndex: initialIndex ?? this.initialIndex,
        taskCategoryIndex: taskCategoryIndex ?? this.taskCategoryIndex,
        taskCategoryList: taskCategoryList ?? this.taskCategoryList,
        allTasksList: allTasksList ?? this.allTasksList,
        todayTasksList: todayTasksList ?? this.todayTasksList,
        weeklyTasksList: weeklyTasksList ?? this.weeklyTasksList,
        filteredTasks:
            filteredTasks ?? this.filteredTasks, // Yeni eklenen state
        selectedTime: selectedTime ?? this.selectedTime,
        selectedDate: selectedDate ?? this.selectedDate,
        reminderDuration: reminderDuration ?? this.reminderDuration,
        searchResults: searchResults ?? this.searchResults);
  }

  int getTaskCount(int index) {
    switch (index) {
      case 1:
        return todayTasksList.length;
      case 2:
        return weeklyTasksList.length;
      default:
        return allTasksList.length;
    }
  }

  @override
  List<Object?> get props => [
        initialIndex,
        taskCategoryList,
        taskCategoryIndex,
        allTasksList,
        todayTasksList,
        weeklyTasksList,
        filteredTasks,
        selectedTime,
        selectedDate,
        reminderDuration,
        searchResults,
      ];
}
