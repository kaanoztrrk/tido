import 'dart:async';
import 'package:TiDo/utils/Helpers/helpers_functions.dart';
import 'package:TiDo/utils/device/device_utility.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../data/services/shared_preferences_service.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState.initial()) {
    on<ChangeThemeColorEvent>(_onChangeThemeColor);
    on<ChangeBackgroundImageEvent>(_onChangeBackgroundImage);
    on<ChangeThemeModeEvent>(_onChangeThemeMode);
    on<ChangeTaskModeEvent>(_onChangeTaskMode);

    // Load the saved theme settings at the start
    _loadSavedTheme();
  }

  void _onChangeThemeColor(
      ChangeThemeColorEvent event, Emitter<ThemeState> emit) async {
    emit(state.copyWith(primaryColor: event.newColor));
    final colorValue = event.newColor.value;
    await SharedPreferencesService.instance.setInt('primary_color', colorValue);

    // If a background image is set, remove it
    await SharedPreferencesService.instance.remove('background_image');
    emit(state.copyWith(backgroundImage: null));
  }

  void _onChangeBackgroundImage(
      ChangeBackgroundImageEvent event, Emitter<ThemeState> emit) async {
    emit(state.copyWith(backgroundImage: event.newImage));

    // Save the background image
    await SharedPreferencesService.instance
        .setString('background_image', event.newImage);

    // Reset color selections
    emit(state.copyWith(primaryColor: Colors.transparent));
  }

  void _onChangeThemeMode(
      ChangeThemeModeEvent event, Emitter<ThemeState> emit) async {
    emit(state.copyWith(themeMode: event.themeMode));
    await SharedPreferencesService.instance
        .setString('theme_mode', event.themeMode.toString());
  }

  Future<void> _loadSavedTheme() async {
    final savedColorValue =
        await SharedPreferencesService.instance.getInt('primary_color');
    final savedBackgroundImage =
        await SharedPreferencesService.instance.getString('background_image');
    final savedThemeModeString =
        await SharedPreferencesService.instance.getString('theme_mode');

    ThemeMode? savedThemeMode;
    if (savedThemeModeString != null) {
      savedThemeMode = ThemeMode.values.firstWhere(
        (mode) => mode.toString() == savedThemeModeString,
        orElse: () => ThemeMode.system,
      );
    }

    if (savedBackgroundImage != null) {
      add(ChangeBackgroundImageEvent(savedBackgroundImage));
    } else if (savedColorValue != null) {
      final savedColor = Color(savedColorValue);
      add(ChangeThemeColorEvent(savedColor));
    }

    if (savedThemeMode != null) {
      add(ChangeThemeModeEvent(savedThemeMode));
    }
  }

  void _onChangeTaskMode(ChangeTaskModeEvent event, Emitter<ThemeState> emit) {
    SharedPreferencesService.instance.setBool("task_mode", event.newTaskMode);
    emit(state.copyWith(taskMode: event.newTaskMode));
  }
}
