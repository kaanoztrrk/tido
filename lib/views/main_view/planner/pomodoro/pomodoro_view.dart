import 'package:TiDo/common/widget/appbar/appbar.dart';
import 'package:TiDo/common/widget/button/ratio_button.dart';
import 'package:TiDo/utils/Constant/colors.dart';
import 'package:TiDo/utils/Constant/sizes.dart';
import 'package:TiDo/utils/Device/device_utility.dart';
import 'package:TiDo/utils/Helpers/helpers_functions.dart';
import 'package:TiDo/utils/Theme/custom_theme.dart/text_theme.dart';
import 'package:TiDo/views/main_view/planner/pomodoro/widget/progress_widget/dot_progress.dart';
import 'package:TiDo/views/main_view/planner/pomodoro/widget/time_selected_options/time_options.dart';
import 'package:TiDo/views/main_view/planner/pomodoro/widget/timer/circular_timer.dart';
import 'package:TiDo/data/services/study_technique/pomodoro_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widget/time_controller/time_controller.dart';

class PomodoroView extends StatelessWidget {
  const PomodoroView({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = ViHelpersFunctions.isDarkMode(context);
    final provider = Provider.of<PomodoroService>(context);
    return Scaffold(
        appBar: ViAppBar(
          showBackArrow: true,
          centerTitle: true,
          title: const Text("Pomodoro"),
          actions: [
            ViRotioButton(
              onTap: () {
                provider.restart();
              },
              child: const Icon(Icons.restart_alt_outlined),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              provider.currentState,
              style: dark
                  ? ViTextTheme.darkTextTheme.headlineLarge
                      ?.copyWith(color: AppColors.white)
                  : ViTextTheme.darkTextTheme.headlineLarge
                      ?.copyWith(color: AppColors.black),
            ),
            const SizedBox(height: ViSizes.spaceBtwSections * 2),
            Center(child: ViCircularTimer(pomodoroService: provider)),
            const SizedBox(height: ViSizes.spaceBtwSections * 2),
            DotProgress(currentStep: provider.rounds, totalSteps: 4),
            const SizedBox(height: ViSizes.spaceBtwSections * 2),
            const TimeOptions(),
          ],
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.all(ViSizes.defaultSpace),
          height: ViDeviceUtils.getScreenHeigth(context) * 0.1,
          width: double.infinity,
          child: const TimeController(),
        ));
  }
}
