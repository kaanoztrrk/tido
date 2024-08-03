import 'package:flutter/material.dart';
import 'package:tido/utils/Helpers/helpers_functions.dart';

import '../../../utils/Constant/colors.dart';
import '../../../utils/Theme/custom_theme.dart/text_theme.dart';

class ViPrimaryTitle extends StatelessWidget {
  const ViPrimaryTitle({
    super.key,
    required this.title,
    this.smallText = false,
    this.bigText = false,
    this.primaryTextColor,
    this.secondTextColor,
    this.textAlign,
  });

  final String title;
  final bool smallText;
  final bool bigText;
  final Color? primaryTextColor;
  final Color? secondTextColor;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    var textStyle;

    if (smallText) {
      textStyle = dark
          ? ViTextTheme.darkTextTheme.titleMedium
          : ViTextTheme.ligthTextTheme.titleMedium;
    } else if (bigText) {
      textStyle = dark
          ? ViTextTheme.darkTextTheme.headlineLarge
          : ViTextTheme.ligthTextTheme.headlineLarge;
    } else {
      textStyle = dark
          ? ViTextTheme.darkTextTheme.titleLarge
          : ViTextTheme.ligthTextTheme.titleLarge;
    }

    var textColor = dark
        ? primaryTextColor ?? AppColors.primaryText
        : secondTextColor ?? AppColors.primaryText;

    return Text(
      title,
      style: textStyle?.copyWith(
        color: textColor,
      ),
      textAlign: textAlign,
    );
  }
}
