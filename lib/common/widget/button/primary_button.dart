import 'package:flutter/material.dart';

import '../../../utils/Constant/colors.dart';
import '../../../utils/Helpers/helpers_functions.dart';
import '../../../utils/Theme/custom_theme.dart/text_theme.dart';

class ViPrimaryButton extends StatelessWidget {
  const ViPrimaryButton({
    super.key,
    required this.text,
    this.onTap,
    required,
  });

  final String text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: ViHelpersFunctions.screenWidth(context),
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient: AppColors.primaryGradientButton,
        ),
        child: Text(
          text,
          style: dark
              ? ViTextTheme.ligthTextTheme.headlineMedium
              : ViTextTheme.darkTextTheme.headlineMedium,
        ),
      ),
    );
  }
}
