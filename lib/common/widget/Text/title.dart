import 'package:flutter/material.dart';

import '../../../utils/Helpers/helpers_functions.dart';
import '../../../utils/Theme/custom_theme.dart/text_theme.dart';

class ViPrimaryTitle extends StatelessWidget {
  const ViPrimaryTitle({
    super.key,
    required this.title,
    this.smallText = false,
    this.bigText = false,
    this.primaryTextColor,
    this.textColor,
    this.textAlign,
  });

  final String title;
  final bool smallText;
  final bool bigText;
  final Color? primaryTextColor;
  final Color? textColor;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);

    // Default style
    TextStyle textStyle = dark
        ? ViTextTheme.darkTextTheme.titleLarge!
        : ViTextTheme.ligthTextTheme.titleLarge!;

    // Adjust text style based on smallText or bigText
    if (smallText) {
      textStyle = dark
          ? ViTextTheme.darkTextTheme.titleSmall!
          : ViTextTheme.ligthTextTheme.titleSmall!;
    } else if (bigText) {
      textStyle = dark
          ? ViTextTheme.darkTextTheme.headlineMedium!
          : ViTextTheme.ligthTextTheme.headlineMedium!;
    }

    // Apply custom text color if provided
    if (textColor != null) {
      textStyle = textStyle.copyWith(color: textColor);
    }

    return Text(
      title,
      style: textStyle,
      textAlign: textAlign,
    );
  }
}
