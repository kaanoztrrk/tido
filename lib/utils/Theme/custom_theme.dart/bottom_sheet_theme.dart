import 'package:flutter/material.dart';

import '../../Constant/colors.dart';

class ViBottomSheetTheme {
  ViBottomSheetTheme._();

  static BottomSheetThemeData ligthBottomSheet = const BottomSheetThemeData(
    backgroundColor: AppColors.white, // Burada arka plan rengini tanımlıyoruz
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.0)), // Köşeleri yuvarlayabilirsiniz
    ),
  );

  static BottomSheetThemeData darkBottomSheet = const BottomSheetThemeData(
    backgroundColor: AppColors.dark, // Burada arka plan rengini tanımlıyoruz
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.0)), // Köşeleri yuvarlayabilirsiniz
    ),
  );
}
