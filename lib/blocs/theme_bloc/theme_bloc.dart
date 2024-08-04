import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState.initial()) {
    on<ChangeThemeColorEvent>(_onChangeThemeColor);
    on<ChangeButtonGradientEvent>(_onChangeButtonGradient);
    on<ChangeBackgroundImageEvent>(_onChangeBackgroundImage);
  }

  void _onChangeThemeColor(
      ChangeThemeColorEvent event, Emitter<ThemeState> emit) {
    final newGradient = LinearGradient(
      colors: [event.newColor, event.newColor.withOpacity(0.8)],
    );

    emit(
      state.copyWith(primaryColor: event.newColor),
    );
  }

  void _onChangeButtonGradient(
      ChangeButtonGradientEvent event, Emitter<ThemeState> emit) {
    emit(state.copyWith(primaryGradientButton: event.newGradient));
  }

  void _onChangeBackgroundImage(
      ChangeBackgroundImageEvent event, Emitter<ThemeState> emit) {
    emit(state.copyWith(backgroundImage: event.newImage));
  }
}
