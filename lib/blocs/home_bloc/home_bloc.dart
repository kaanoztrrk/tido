// ignore_for_file: empty_catches

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import '../../data/models/category_model/category_model.dart';
import '../../data/models/task_model/task_model.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final Box<TaskModel> taskBox = Hive.box<TaskModel>('allTasksBox');
  final Box<CategoryModel> categoryBox =
      Hive.box<CategoryModel>('allCategoryBox');
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
    on<LoadCategoryEvent>(_loadCategory);
    on<SearchTasksEvent>(_searchTasks);
    on<StartTimerEvent>(_startTimer);
    on<UpdateRemainingTimeEvent>(_updateRemainingTime);
    on<AddCategoryEvent>(_createCategory);
    on<DeleteCategoryEvent>(_deleteCategory);
    on<UpdateCategoryEvent>(_updateCategory);
    on<DeleteAllCategoryEvent>(_deleteAllCategory);
    // Initial Events
    add(StartTimerEvent());
    add(LoadTasksEvent());
    add(LoadCategoryEvent());
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
      labels: event.labels,
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
      taskBox.putAt(index, event.newTask); // Update task
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
        await taskBox.putAt(index, updatedTask); // Async operation
        emit(state.copyWith(allTasksList: updatedAllTasksList));
      } catch (error) {}
    }
  }

  void _loadTasks(LoadTasksEvent event, Emitter<HomeState> emit) {
    List<TaskModel> tasks = taskBox.values.toList();
    emit(state.copyWith(allTasksList: tasks));
  }

  void _loadCategory(LoadCategoryEvent event, Emitter<HomeState> emit) {
    List<CategoryModel> categories = categoryBox.values.toList();
    // Ensure "All" category is included and immutable
    final allCategory = CategoryModel(name: "All", id: "all");
    final updatedCategories =
        [allCategory] + categories.where((cat) => cat.id != "all").toList();
    emit(state.copyWith(allCategoryList: updatedCategories));
  }

  void _searchTasks(SearchTasksEvent event, Emitter<HomeState> emit) {
    List<TaskModel> searchResults = state.allTasksList
        .where((task) =>
            task.title.toLowerCase().contains(event.query.toLowerCase()))
        .toList();

    emit(state.copyWith(searchResults: searchResults));
  }

  void _onSwipeCard(SwipeCard event, Emitter<HomeState> emit) {
    final List<CategoryModel> updatedList = List.from(state.allCategoryList);
    final swipedCategory = updatedList.removeAt(event.index);
    updatedList.add(swipedCategory);
    emit(state.copyWith(allCategoryList: updatedList));
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

      // Check for null taskTime and parse valid DateTime format
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
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  void _createCategory(AddCategoryEvent event, Emitter<HomeState> emit) {
    List<CategoryModel> updatedCategoryList = List.of(state.allCategoryList);

    CategoryModel newCategory = CategoryModel(
      name: event.categoryName,
    );

    // Ekleme işlemi sırasında key ayarlanmadan önce
    final id = categoryBox.add(newCategory);
    newCategory = newCategory.copyWith(id: id.toString());

    updatedCategoryList.add(newCategory);
    emit(state.copyWith(allCategoryList: updatedCategoryList));
  }

  void _deleteAllCategory(
      DeleteAllCategoryEvent event, Emitter<HomeState> emit) async {
    await categoryBox.clear();
    emit(state.copyWith(allCategoryList: []));
  }

  void _deleteCategory(
      DeleteCategoryEvent event, Emitter<HomeState> emit) async {
    List<CategoryModel> updatedAllCategoryList = List.of(state.allCategoryList);
    int categoryIndex = updatedAllCategoryList
        .indexWhere((cat) => cat.name == event.categoryModel.name);

    if (categoryIndex != -1) {
      final categoryId = categoryBox.keys.firstWhere(
        (key) => categoryBox.get(key)?.name == event.categoryModel.name,
        orElse: () => null,
      );

      if (categoryId != null) {
        await categoryBox.delete(categoryId);
        updatedAllCategoryList.removeAt(categoryIndex);
      }
    }

    emit(state.copyWith(allCategoryList: updatedAllCategoryList));
  }

  void _updateCategory(
      UpdateCategoryEvent event, Emitter<HomeState> emit) async {
    List<CategoryModel> updatedAllCategoryList = List.of(state.allCategoryList);
    int index = updatedAllCategoryList
        .indexWhere((cat) => cat.name == event.oldCategory.name);

    if (index != -1) {
      updatedAllCategoryList[index] = event.newCategory;
      final categoryId = categoryBox.keys.firstWhere(
        (key) => categoryBox.get(key)?.name == event.oldCategory.name,
        orElse: () => null,
      );

      if (categoryId != null) {
        await categoryBox.put(categoryId, event.newCategory);
      }
    }

    emit(state.copyWith(allCategoryList: updatedAllCategoryList));
  }
}
