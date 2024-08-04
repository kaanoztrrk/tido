import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tido/data/models/category_model/category_model.dart';
import 'package:tido/data/models/task_model/task_model.dart';

class HomeState extends Equatable {
  final int initialIndex;
  final List<CategoryModel> allCategoryList;
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
    required this.allCategoryList,
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
    return HomeState(
      searchResults: const [],
      initialIndex: 0,
      taskCategoryIndex: 0,
      allCategoryList: [
        CategoryModel(id: 'all', name: "All"),
      ],
      allTasksList: const [],
      filteredTasks: const [],
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
    List<CategoryModel>? allCategoryList, // Güncellenmiş isim
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
      allCategoryList:
          allCategoryList ?? this.allCategoryList, // Güncellenmiş isim
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
        allCategoryList, // Güncellenmiş isim
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
