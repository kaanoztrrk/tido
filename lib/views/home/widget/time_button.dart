import 'package:flutter/material.dart';
import 'package:tido/common/widget/button/ratio_button.dart';
import 'package:tido/utils/Constant/colors.dart';
import 'package:tido/utils/Helpers/helpers_functions.dart';

import '../../../utils/Theme/custom_theme.dart/text_theme.dart';

class ViTimeButton extends StatelessWidget {
  final VoidCallback? createTaskTap;
  final VoidCallback? notificationTaskTap;
  final String timeText;
  final IconData icon;

  const ViTimeButton({
    Key? key,
    this.createTaskTap,
    required this.timeText,
    required this.icon,
    this.notificationTaskTap,
  }) : super(key: key);

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: notificationTaskTap,
              child: Text(
                timeText,
                style: dark
                    ? ViTextTheme.darkTextTheme.titleLarge
                    : ViTextTheme.darkTextTheme.titleLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
