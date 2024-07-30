import 'package:flutter/material.dart';

import '../../Constant/colors.dart';

class ViSwitchTheme {
  ViSwitchTheme._();

  static SwitchThemeData lightSwitchTheme = SwitchThemeData(
    thumbColor: WidgetStateProperty.all(AppColors.primary),
    trackColor: WidgetStateProperty.all(AppColors.darkGrey),
    overlayColor: WidgetStateProperty.all(AppColors.primary.withOpacity(0.5)),
  );

  static SwitchThemeData darkSwitchTheme = SwitchThemeData(
    thumbColor: WidgetStateProperty.all(AppColors.white),
    trackColor: WidgetStateProperty.all(AppColors.darkGrey),
    overlayColor: WidgetStateProperty.all(AppColors.white.withOpacity(0.5)),
  );
}
