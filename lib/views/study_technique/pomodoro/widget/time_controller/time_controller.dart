import 'package:TiDo/utils/Constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../../../../../data/services/study_technique/pomodoro_service.dart';

class TimeController extends StatefulWidget {
  const TimeController({super.key});

  @override
  State<TimeController> createState() => _TimeControllerState();
}

class _TimeControllerState extends State<TimeController> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PomodoroService>(context);
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: () {
          provider.timerPlaying
              ? Provider.of<PomodoroService>(context, listen: false).pause()
              : Provider.of<PomodoroService>(context, listen: false).start();
        },
        icon: Icon(
          provider.timerPlaying ? Iconsax.pause : Iconsax.play,
          size: 30,
          color: AppColors.white,
        ),
      ),
    );
  }
}
