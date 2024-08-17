import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ChangeThemeColorEvent extends ThemeEvent {
  final Color newColor;

  const ChangeThemeColorEvent(this.newColor);

  @override
  List<Object> get props => [newColor];
}

class ChangeButtonGradientEvent extends ThemeEvent {
  final Gradient newGradient;

  const ChangeButtonGradientEvent(this.newGradient);
}

class ChangeBackgroundImageEvent extends ThemeEvent {
  final String newImage;

  const ChangeBackgroundImageEvent(this.newImage);

  @override
  List<Object> get props => [newImage];
}

class ChangeThemeModeEvent extends ThemeEvent {
  final ThemeMode themeMode;

  const ChangeThemeModeEvent(this.themeMode);
}
