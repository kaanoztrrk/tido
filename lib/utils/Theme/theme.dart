import 'package:flutter/material.dart';
import 'package:tido/utils/Constant/colors.dart';
import 'package:tido/utils/Theme/custom_theme.dart/bottom_sheet_theme.dart';
import 'package:tido/utils/Theme/custom_theme.dart/switch_theme.dart';
import 'package:tido/utils/Theme/custom_theme.dart/text_theme.dart';
import 'package:tido/utils/Theme/custom_theme.dart/text_field_theme.dart';

class ViAppTheme {
  ViAppTheme._();

  static ThemeData getLightTheme(Color primaryColor) {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.light,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: AppColors.light,
      textTheme: ViTextTheme.ligthTextTheme,
      inputDecorationTheme: ViTextFormFieldTheme.ligthInputDecorationTheme,
      bottomSheetTheme: ViBottomSheetTheme.ligthBottomSheet,
      switchTheme: ViSwitchTheme.lightSwitchTheme,
    );
  }

  static ThemeData getDarkTheme(Color primaryColor) {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: AppColors.dark,
      textTheme: ViTextTheme.darkTextTheme,
      inputDecorationTheme: ViTextFormFieldTheme.darkInputDecorationTheme,
      bottomSheetTheme: ViBottomSheetTheme.darkBottomSheet,
      switchTheme: ViSwitchTheme.darkSwitchTheme,
    );
  }
}
