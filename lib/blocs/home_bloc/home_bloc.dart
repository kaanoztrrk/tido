import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import '../../data/models/task_model/task_model.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final Box<TaskModel> taskBox = Hive.box<TaskModel>('allTasksBox');
  Timer? _timer;

  HomeBloc() : super(HomeState.initial()) {
    on<UpdateTab>(_onUpdateTab);
    on<CategoryUpdateTab>(_onCategoryUpdateTab);
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
    on<AddCategoryEvent>(_addCategory);
    on<RemoveCategoryEvent>(_removeCategory);

    add(StartTimerEvent());
    add(LoadTasksEvent());
  }

  void _onUpdateTab(UpdateTab event, Emitter<HomeState> emit) {
    emit(state.copyWith(initialIndex: event.index));
  }

  void _onCategoryUpdateTab(CategoryUpdateTab event, Emitter<HomeState> emit) {
    emit(state.copyWith(taskCategoryIndex: event.index));
  }

  void _deleteAllTasks(DeleteAllTasksEvent event, Emitter<HomeState> emit) {
    taskBox.clear();
    emit(state.copyWith(allTasksList: []));
  }

  void _deleteTask(DeleteToDoEvent event, Emitter<HomeState> emit) {
    List<TaskModel> updatedAllTasksList = List.of(state.allTasksList);
    int taskIndex = updatedAllTasksList.indexOf(event.task);

    if (taskIndex != -1) {
      updatedAllTasksList.removeAt(taskIndex);
      taskBox.deleteAt(taskIndex);
    }

    emit(state.copyWith(allTasksList: updatedAllTasksList));
  }

  void _createTask(CreateToDoEvent event, Emitter<HomeState> emit) {
    List<TaskModel> newAllTasksList = List.of(state.allTasksList);

    TaskModel newTask = TaskModel(
      title: event.title,
      description: event.description,
      taskTime: event.taskTime,
      participantImages: event.participantImages,
      files: event.files,
    );

    newAllTasksList.add(newTask);
    taskBox.add(newTask);

    emit(state.copyWith(allTasksList: newAllTasksList));
  }

  void _updateTask(UpdateToDoEvent event, Emitter<HomeState> emit) {
    List<TaskModel> updatedAllTasksList = List.of(state.allTasksList);
    int index = updatedAllTasksList.indexOf(event.oldTask);

    if (index != -1) {
      updatedAllTasksList[index] = event.newTask;
      taskBox.putAt(index, event.newTask);
    }

    emit(state.copyWith(allTasksList: updatedAllTasksList));
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
        await taskBox.putAt(index, updatedTask); // Asenkron işlemi bekleyin
        print("Görev durumu başarıyla güncellendi: $updatedTask");
        emit(state.copyWith(allTasksList: updatedAllTasksList));
      } catch (error) {
        print("Görev durumu güncellenirken hata oluştu: $error");
        // Hata durumunda gerekli işlemleri yapabilirsiniz
      }
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
    final List<String> updatedList = List.from(state.taskCategoryList);
    final swipedTask = updatedList.removeAt(event.index);
    updatedList.add(swipedTask);
    emit(state.copyWith(taskCategoryList: updatedList));
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
    final filteredTasks = state.allTasksList.where((task) {
      final taskDate = task.taskTime;
      return taskDate != null &&
          taskDate.year == event.date.year &&
          taskDate.month == event.date.month &&
          taskDate.day == event.date.day;
    }).toList();
    emit(state.copyWith(filteredTasks: filteredTasks));
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

      // taskTime'ı null kontrolü ve geçerli DateTime formatına dönüştürme
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
        print("Tarih formatı hatalı: $e");
        emit(state.copyWith(
          remainingTime: "Invalid Date Format",
          currentTask: task,
        ));
        return;
      }

      final difference = taskTime.difference(now);

      String remainingTime;
      if (difference.isNegative) {
        remainingTime = "Task Time Passed";
      } else {
        remainingTime = _formatDuration(difference);
      }

      emit(state.copyWith(
        remainingTime: remainingTime,
        currentTask: task,
      ));
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours.remainder(24));
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  void _addCategory(AddCategoryEvent event, Emitter<HomeState> emit) {
    List<String> updatedCategoryList = List.of(state.taskCategoryList);
    if (!updatedCategoryList.contains(event.categoryName)) {
      updatedCategoryList.add(event.categoryName);
    }
    emit(state.copyWith(taskCategoryList: updatedCategoryList));
  }

  void _removeCategory(RemoveCategoryEvent event, Emitter<HomeState> emit) {
    List<String> updatedCategoryList = List.of(state.taskCategoryList);
    updatedCategoryList.remove(event.categoryName);
    emit(state.copyWith(taskCategoryList: updatedCategoryList));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
