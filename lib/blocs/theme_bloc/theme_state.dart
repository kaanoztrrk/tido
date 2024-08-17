import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tido/utils/Constant/image_strings.dart';

import '../../utils/Constant/colors.dart';

class ThemeState extends Equatable {
  final List<Color> allColorList;
  final List<String> allBackgroundList;
  final Color primaryColor;
  final String? backgroundImage;
  final ThemeMode themeMode;

  const ThemeState({
    required this.primaryColor,
    required this.backgroundImage,
    required this.allColorList,
    required this.allBackgroundList,
    required this.themeMode,
  });

  factory ThemeState.initial() {
    return const ThemeState(
      primaryColor: AppColors.primary,
      allColorList: [
        AppColors.primary,
        AppColors.secondary,
        AppColors.darkGreen,
        AppColors.green,
        AppColors.yellow,
        AppColors.red,
        AppColors.darkBlue,
        AppColors.pink,
        AppColors.darkPurple,
        AppColors.purple,
        AppColors.darkBrown,
        AppColors.borwn,
      ],
      allBackgroundList: [
        ViImages.texture_1,
        ViImages.texture_2,
        ViImages.texture_3,
      ],
      backgroundImage: null,
      themeMode: ThemeMode.system,
    );
  }

  ThemeState copyWith({
    Color? primaryColor,
    String? backgroundImage,
    List<Color>? allColorList,
    List<Gradient>? allGradientList,
    List<String>? allTextureList,
    ThemeMode? themeMode,
  }) {
    return ThemeState(
      allColorList: allColorList ?? this.allColorList,
      allBackgroundList: allTextureList ?? allBackgroundList,
      primaryColor: primaryColor ?? this.primaryColor,
      backgroundImage: backgroundImage,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  List<Object?> get props => [
        primaryColor,
        allColorList,
        allBackgroundList,
        backgroundImage,
        themeMode
      ];
}
