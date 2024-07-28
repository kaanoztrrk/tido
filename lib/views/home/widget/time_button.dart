import 'package:flutter/material.dart';
import 'package:tido/common/widget/button/ratio_button.dart';
import 'package:tido/utils/Constant/colors.dart';
import 'package:tido/utils/Helpers/helpers_functions.dart';

import '../../../utils/Theme/custom_theme.dart/text_theme.dart';

class ViTimeButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String timeText;
  final IconData icon;

  const ViTimeButton({
    Key? key,
    this.onTap,
    required this.timeText,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(50),
        ),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Row(
          children: [
            ViRotioButton(
              child: Icon(icon),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                timeText,
                style: dark
                    ? ViTextTheme.darkTextTheme.titleLarge
                    : ViTextTheme.darkTextTheme.titleLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
