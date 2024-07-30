import 'package:flutter/material.dart';
import 'package:tido/common/widget/button/ratio_button.dart';
import 'package:tido/utils/Constant/colors.dart';
import 'package:tido/utils/Helpers/helpers_functions.dart';

import '../../../utils/Theme/custom_theme.dart/text_theme.dart';

class ViTimeButton extends StatelessWidget {
  final VoidCallback? createTaskTap;
  final VoidCallback? notificationTaskTap;
  final String? timeText;
  final IconData icon;

  const ViTimeButton({
    super.key,
    this.createTaskTap,
    this.timeText,
    required this.icon,
    this.notificationTaskTap,
  });

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(50),
      ),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Row(
        children: [
          GestureDetector(
            onTap: createTaskTap,
            child: ViRotioButton(
              child: Icon(icon),
            ),
          ),
          if (timeText != null &&
              timeText!
                  .isNotEmpty) // Only show padding if timeText is not null or empty
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GestureDetector(
                onTap: notificationTaskTap,
                child: Text(
                  timeText!,
                  style: dark
                      ? ViTextTheme.ligthTextTheme.titleLarge
                      : ViTextTheme.darkTextTheme.titleLarge,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
