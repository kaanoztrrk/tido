import 'package:flutter/material.dart';
import 'package:tido/utils/Helpers/helpers_functions.dart';

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

    return Text(
      title,
      style: dark
          ? ViTextTheme.darkTextTheme.titleLarge
          : ViTextTheme.ligthTextTheme.titleLarge,
      textAlign: textAlign,
    );
  }
}
