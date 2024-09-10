import 'package:TiDo/utils/Constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../data/services/study_technique/pomodoro_service.dart';

class TimeOptions extends StatelessWidget {
  const TimeOptions({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> selectableTimes = [
      "300",
      "600",
      "900",
      "1200",
      "1500",
      "1800",
      "2100",
      "2400",
      "2700",
      "3000",
      "3300",
    ];

    final provider = Provider.of<PomodoroService>(context);

    return SingleChildScrollView(
      controller: ScrollController(initialScrollOffset: 155),
      scrollDirection: Axis.horizontal,
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: selectableTimes.map((item) {
          return GestureDetector(
            onTap: () => provider.selectTime(double.parse(item)),
            child: Container(
              width: 70,
              height: 50,
              decoration: int.parse(item) == provider.selectedTime
                  ? BoxDecoration(
                      color: AppColors.white,
                      border: Border.all(width: 3, color: AppColors.white),
                      borderRadius: BorderRadius.circular(5),
                    )
                  : BoxDecoration(
                      border: Border.all(
                          width: 3, color: AppColors.white.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(5),
                    ),
              alignment: Alignment.center,
              child: Text(
                (int.parse(item) ~/ 60).toString(),
                style: int.parse(item) == provider.selectedTime
                    ? TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )
                    : const TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
