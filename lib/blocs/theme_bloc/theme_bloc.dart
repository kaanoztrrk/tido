import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/services/shared_preferences_service.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState.initial()) {
    on<ChangeThemeColorEvent>(_onChangeThemeColor);
    on<ChangeBackgroundImageEvent>(_onChangeBackgroundImage);

    // Uygulama başlarken kaydedilen temayı yükle
    _loadSavedTheme();
  }

  void _onChangeThemeColor(
      ChangeThemeColorEvent event, Emitter<ThemeState> emit) async {
    emit(state.copyWith(primaryColor: event.newColor));
    final colorValue = event.newColor.value;
    await SharedPreferencesService.instance.setInt('primary_color', colorValue);

    // Eğer arka plan resmi varsa, onu null yap
    await SharedPreferencesService.instance.remove('background_image');
    emit(state.copyWith(backgroundImage: null));
  }

  void _onChangeBackgroundImage(
      ChangeBackgroundImageEvent event, Emitter<ThemeState> emit) async {
    emit(state.copyWith(backgroundImage: event.newImage));

    // Arka plan resmini kaydet
    await SharedPreferencesService.instance
        .setString('background_image', event.newImage);

    // Renk seçimlerini varsayılan hale getir
    emit(state.copyWith(primaryColor: Colors.transparent));
  }

  Future<void> _loadSavedTheme() async {
    final savedColorValue =
        await SharedPreferencesService.instance.getInt('primary_color');
    final savedBackgroundImage =
        await SharedPreferencesService.instance.getString('background_image');

    if (savedBackgroundImage != null) {
      add(ChangeBackgroundImageEvent(savedBackgroundImage));
    } else if (savedColorValue != null) {
      final savedColor = Color(savedColorValue);
      add(ChangeThemeColorEvent(savedColor));
    }
  }
}
