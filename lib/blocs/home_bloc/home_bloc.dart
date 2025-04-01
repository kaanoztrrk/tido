import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:workmanager/workmanager.dart';
import '../../data/models/task_model/task_model.dart';
import '../../data/services/local_notification.dart';
import 'home_event.dart';
import 'home_state.dart';
import 'package:timezone/timezone.dart' as tz;

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final Box<TaskModel> taskBox = Hive.box<TaskModel>('allTasksBox');
  Timer? _timer;

  HomeBloc() : super(HomeState.initial()) {
    on<UpdateTab>(_onUpdateTab);
    on<SwipeCard>(_onSwipeCard);
    on<TimeSelected>(_onTimeSelected);
    on<DateSelected>(_onDateSelected);
    on<ReminderSelected>(_onReminderSelected);
    on<FilterTasksByDate>(_onFilterTasksByDate);
    on<CreateToDoEvent>(_createTask);
    on<ChangeCheckBoxEvent>(_changeCheckBox);
    on<DeleteToDoEvent>(_deleteTask);
    on<DeleteAllTasksEvent>(_deleteAllTasks);
    on<UpdateToDoEvent>(_updateTask);
    on<LoadTasksEvent>(_loadTasks);
    on<SearchTasksEvent>(_searchTasks);
    on<StartTimerEvent>(_startTimer);
    on<UpdateRemainingTimeEvent>(_updateRemainingTime);

    // Initial Events
    add(StartTimerEvent());
    add(LoadTasksEvent());
  }

  void _onUpdateTab(UpdateTab event, Emitter<HomeState> emit) {
    emit(state.copyWith(initialIndex: event.index));
  }

  void _deleteAllTasks(DeleteAllTasksEvent event, Emitter<HomeState> emit) {
    taskBox.clear();
    emit(state.copyWith(allTasksList: []));
  }

  void _createTask(CreateToDoEvent event, Emitter<HomeState> emit) async {
    List<TaskModel> newAllTasksList = List.of(state.allTasksList);

    int newId = newAllTasksList.isNotEmpty ? newAllTasksList.last.id + 1 : 1;

    TaskModel newTask = TaskModel(
        id: newId,
        title: event.title,
        description: event.description,
        taskTime: event.taskTime,
        participantImages: event.participantImages,
        files: event.files,
        priority: event.priority);

    newAllTasksList.add(newTask);
    taskBox.add(newTask);

    emit(state.copyWith(allTasksList: newAllTasksList));

    // Kullanıcının Firestore veritabanına eklenmesi
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      CollectionReference tasksRef = FirebaseFirestore.instance
          .collection('user_tasks')
          .doc(userId)
          .collection('tasks');

      await tasksRef.add({
        'taskId': newId,
        'title': event.title,
        'description': event.description,
        'taskTime': event.taskTime?.toIso8601String(),
        'participantImages': event.participantImages,
        'files': event.files,
        'createdAt': FieldValue.serverTimestamp(),
        'priority': event.priority
      });
    }
  }

  void _updateTask(UpdateToDoEvent event, Emitter<HomeState> emit) async {
    List<TaskModel> updatedAllTasksList = List.of(state.allTasksList);
    int index = updatedAllTasksList.indexOf(event.oldTask);

    if (index != -1) {
      updatedAllTasksList[index] = event.newTask;
      taskBox.putAt(index, event.newTask); // Task güncelleme işlemi

      // State'i güncelle
      emit(state.copyWith(allTasksList: updatedAllTasksList));

      // Firestore veritabanına görevi güncelleme işlemi
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String userId = user.uid;

        // Firestore collection referansı
        CollectionReference tasksRef = FirebaseFirestore.instance
            .collection('user_tasks')
            .doc(userId)
            .collection('tasks');

        // Firestore'da mevcut görevi güncelle
        try {
          QuerySnapshot query =
              await tasksRef.where('taskId', isEqualTo: event.oldTask.id).get();

          if (query.docs.isNotEmpty) {
            DocumentSnapshot doc = query.docs.first;

            await doc.reference.update({
              'title': event.newTask.title,
              'description': event.newTask.description,
              'taskTime': event.newTask.taskTime?.toIso8601String(),
              'participantImages': event.newTask.participantImages,
              'files': event.newTask.files,
              'updatedAt': FieldValue.serverTimestamp(),
            });
          }
        } catch (error) {
          print('Firestore update error: $error');
        }
      }
    }
  }

  void _deleteTask(DeleteToDoEvent event, Emitter<HomeState> emit) async {
    List<TaskModel> updatedAllTasksList = List.of(state.allTasksList);
    int taskIndex =
        updatedAllTasksList.indexWhere((task) => task.id == event.task.id);

    if (taskIndex != -1) {
      // Görevi listeden ve Hive'dan sil
      updatedAllTasksList.removeAt(taskIndex);
      taskBox.deleteAt(taskIndex);

      emit(state.copyWith(allTasksList: updatedAllTasksList));

      // Firestore veritabanından görevi silme
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String userId = user.uid;

        // Firestore collection referansı
        CollectionReference tasksRef = FirebaseFirestore.instance
            .collection('user_tasks')
            .doc(userId)
            .collection('tasks');

        // Firestore'da görevi sil
        QuerySnapshot query =
            await tasksRef.where('taskId', isEqualTo: event.task.id).get();
        if (query.docs.isNotEmpty) {
          DocumentSnapshot doc = query.docs.first;
          await doc.reference.delete();
        }
      }
    }
  }

  void _changeCheckBox(
      ChangeCheckBoxEvent event, Emitter<HomeState> emit) async {
    int index =
        state.allTasksList.indexWhere((task) => task.id == event.task.id);

    if (index != -1) {
      TaskModel updatedTask = event.task.copyWith(isChecked: event.isChecked);

      List<TaskModel> updatedAllTasksList = List.from(state.allTasksList);
      updatedAllTasksList[index] = updatedTask;

      try {
        await taskBox.putAt(index, updatedTask); // Async operation
        emit(state.copyWith(allTasksList: updatedAllTasksList));
      } catch (error) {}
    }
  }

  void _loadTasks(LoadTasksEvent event, Emitter<HomeState> emit) {
    List<TaskModel> tasks = taskBox.values.toList();
    emit(state.copyWith(allTasksList: tasks));
  }

  void _searchTasks(SearchTasksEvent event, Emitter<HomeState> emit) {
    List<TaskModel> searchResults = state.allTasksList
        .where((task) =>
            task.title.toLowerCase().contains(event.query.toLowerCase()))
        .toList();

    emit(state.copyWith(searchResults: searchResults));
  }

  void _onSwipeCard(SwipeCard event, Emitter<HomeState> emit) {
    // Kategori ile ilgili işlem kaldırıldı
  }

  void _onTimeSelected(TimeSelected event, Emitter<HomeState> emit) {
    emit(state.copyWith(selectedTime: event.selectedTime));
  }

  void _onDateSelected(DateSelected event, Emitter<HomeState> emit) {
    emit(state.copyWith(selectedDate: event.selectedDate));
  }

  void _onReminderSelected(ReminderSelected event, Emitter<HomeState> emit) {
    emit(state.copyWith(reminderDuration: event.reminderDuration));
  }

  void _onFilterTasksByDate(FilterTasksByDate event, Emitter<HomeState> emit) {
    if (state.selectedDate == event.date) {
      return;
    }

    final filteredTasks = state.allTasksList.where((task) {
      final taskDate = task.taskTime;
      return taskDate != null &&
          taskDate.year == event.date.year &&
          taskDate.month == event.date.month &&
          taskDate.day == event.date.day;
    }).toList();

    emit(state.copyWith(
      filteredTasks: filteredTasks,
      selectedDate: event.date,
    ));
  }

  void _startTimer(StartTimerEvent event, Emitter<HomeState> emit) {
    _timer?.cancel();
    int remainingTime = 60;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      remainingTime--;
      add(UpdateRemainingTimeEvent(remainingTime.toString()));
      if (remainingTime <= 0) {
        _timer?.cancel();
      }
    });
  }

  void _updateRemainingTime(
      UpdateRemainingTimeEvent event, Emitter<HomeState> emit) {
    if (state.allTasksList.isNotEmpty) {
      final task = state.allTasksList.first;
      final now = DateTime.now();

      if (task.taskTime == null) {
        emit(state.copyWith(
          remainingTime: "",
          currentTask: task,
        ));
        return;
      }

      DateTime taskTime;
      try {
        taskTime = DateTime.parse(task.taskTime.toString());
      } catch (e) {
        emit(state.copyWith(
          remainingTime: "Invalid Date Format",
          currentTask: task,
        ));
        return;
      }

      final difference = taskTime.difference(now);
      String remainingTime = difference.isNegative
          ? "Task Time Passed"
          : _formatDuration(difference);

      emit(state.copyWith(
        remainingTime: remainingTime,
        currentTask: task,
      ));
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
