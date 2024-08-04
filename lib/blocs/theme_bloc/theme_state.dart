import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tido/utils/Constant/image_strings.dart';

import '../../utils/Constant/colors.dart';

class ThemeState extends Equatable {
  final List<Color> allColorList;
  final List<Gradient> allGradientList;
  final List<String> allTextureList;
  final Color primaryColor;
  final Gradient primaryGradientButton;
  final String? backgroundImage;

  ThemeState({
    required this.primaryColor,
    required this.primaryGradientButton,
    required this.backgroundImage,
    required this.allColorList,
    required this.allGradientList,
    required this.allTextureList,
  });

  factory ThemeState.initial() {
    return ThemeState(
      primaryColor: AppColors.primary,
      primaryGradientButton: const LinearGradient(
        begin: Alignment(0.0, 0.0),
        end: Alignment(0.707, -0.707),
        colors: [AppColors.primary, AppColors.secondary],
      ),
      allColorList: const [
        AppColors.primary,
        AppColors.thistle,
        AppColors.fairyTile,
        AppColors.carnotionPink,
        AppColors.uranianBlue,
        AppColors.ligthSkyBlue,
      ],
      allGradientList: const [
        AppColors.primaryGradientButton,
        AppColors.thistleGradientButton,
        AppColors.fairyTileGradientButton,
        AppColors.carnotionPinkGradientButton,
        AppColors.primaryGradientButton,
        AppColors.ligthSkyBlueGradientButton,
      ],
      allTextureList: const [
        ViImages.texture_1,
        ViImages.texture_2,
        ViImages.texture_3,
      ],
      backgroundImage: null,
    );
  }

  ThemeState copyWith({
    Color? primaryColor,
    Gradient? primaryGradientButton,
    String? backgroundImage,
    List<Color>? allColorList,
    List<Gradient>? allGradientList,
    List<String>? allTextureList,
  }) {
    return ThemeState(
      allColorList: allColorList ?? this.allColorList,
      allGradientList: allGradientList ?? this.allGradientList,
      allTextureList: allTextureList ?? this.allTextureList,
      primaryColor: primaryColor ?? this.primaryColor,
      primaryGradientButton:
          primaryGradientButton ?? this.primaryGradientButton,
      backgroundImage: backgroundImage,
    );
  }

  @override
  List<Object?> get props => [
        primaryColor,
        primaryGradientButton,
        allColorList,
        allGradientList,
        allTextureList,
        backgroundImage
      ];
}
