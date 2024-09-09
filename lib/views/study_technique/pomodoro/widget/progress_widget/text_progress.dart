import 'package:TiDo/utils/Constant/colors.dart';
import 'package:TiDo/utils/Theme/custom_theme.dart/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../data/services/study_technique/pomodoro_service.dart';

class TextProgress extends StatelessWidget {
  const TextProgress({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PomodoroService>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Text(
              "${provider.rounds}/4",
              style: ViTextTheme.darkTextTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold, color: AppColors.grey),
            ),
            Text(
              "Round",
              style: ViTextTheme.darkTextTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold, color: AppColors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
