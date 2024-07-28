import 'package:flutter/material.dart';
import 'package:tido/utils/Constant/colors.dart';
import 'package:tido/utils/Theme/bottom_sheet_theme.dart';
import 'package:tido/utils/Theme/custom_theme.dart/text_theme.dart';
import 'package:tido/utils/Theme/custom_theme.dart/text_field_theme.dart';

class ViAppTheme {
  ViAppTheme._();

  //* Ligth Theme */

  static ThemeData ligthTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.light,
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: AppColors.ligth,
      textTheme: ViTextTheme.ligthTextTheme,
      inputDecorationTheme: ViTextFormFieldTheme.ligthInputDecorationTheme,
      bottomSheetTheme: ViBottomSheetTheme.ligthBottomSheet);

  //* Dark Theme */

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: AppColors.dark,
    textTheme: ViTextTheme.darkTextTheme,
    inputDecorationTheme: ViTextFormFieldTheme.darkInputDecorationTheme,
    bottomSheetTheme: ViBottomSheetTheme.darkBottomSheet,
  );
}
