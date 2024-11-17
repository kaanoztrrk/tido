import 'package:TiDo/utils/Constant/colors.dart';
import 'package:TiDo/utils/Device/device_utility.dart';
import 'package:TiDo/utils/Theme/custom_theme.dart/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../data/services/study_technique/pomodoro_service.dart';

class DigitalTimer extends StatelessWidget {
  const DigitalTimer({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PomodoroService>(context);
    final seconds = provider.currentDuration % 60;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: ViDeviceUtils.getScreenWidth(context) / 3.2,
          height: 170,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              (provider.currentDuration ~/ 60).toString(),
              style: ViTextTheme.darkTextTheme.headlineLarge?.copyWith(
                fontSize: ViDeviceUtils.getScreenHeigth(context) * 0.1,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          ":",
          style: ViTextTheme.darkTextTheme.headlineLarge,
        ),
        const SizedBox(width: 10),
        Container(
          width: ViDeviceUtils.getScreenWidth(context) / 3.2,
          height: 170,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              seconds == 0 ? "${seconds.round()}0" : seconds.round().toString(),
              style: ViTextTheme.darkTextTheme.headlineLarge?.copyWith(
                  fontSize: ViDeviceUtils.getScreenHeigth(context) * 0.1,
                  color: Theme.of(context).primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
