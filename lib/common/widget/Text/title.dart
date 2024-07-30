import 'package:flutter/material.dart';
import 'package:tido/utils/Helpers/helpers_functions.dart';

import '../../../utils/Constant/colors.dart';
import '../../../utils/Theme/custom_theme.dart/text_theme.dart';

class ViPrimaryTitle extends StatelessWidget {
  const ViPrimaryTitle({
    super.key,
    required this.title,
    this.smallText = false,
    this.primaryTextColor,
    this.secondTextColor,
  });

  final String title;
  final bool smallText;
  final Color? primaryTextColor;
  final Color? secondTextColor;

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    var textStyle = dark
        ? (smallText
            ? ViTextTheme.darkTextTheme.titleMedium
            : ViTextTheme.darkTextTheme.titleLarge)
        : (smallText
            ? ViTextTheme.ligthTextTheme.titleMedium
            : ViTextTheme.ligthTextTheme.titleLarge);

    var textColor = dark
        ? primaryTextColor ?? AppColors.primaryText
        : secondTextColor ?? AppColors.primaryText;

    return Text(
      title,
      style: textStyle?.copyWith(color: textColor),
    );
  }
}
