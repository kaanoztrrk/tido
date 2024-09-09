import 'package:TiDo/utils/Constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../data/services/study_technique/pomodoro_service.dart';

class TimeDropdownButton extends StatelessWidget {
  const TimeDropdownButton({super.key});

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

    return DropdownButton<String>(
      value: provider.selectedTime.toString(),
      icon: Icon(Icons.timer, color: AppColors.white),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
      dropdownColor: AppColors.primary,
      onChanged: (String? newValue) {
        if (newValue != null) {
          provider.selectTime(double.parse(newValue));
        }
      },
      items: selectableTimes.map<DropdownMenuItem<String>>((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Container(
            width: 70,
            height: 50,
            decoration: BoxDecoration(
              color: double.parse(item) == provider.selectedTime
                  ? AppColors.white
                  : Colors.transparent,
              border: Border.all(
                width: 3,
                color: double.parse(item) == provider.selectedTime
                    ? AppColors.white
                    : AppColors.white.withOpacity(0.5),
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            alignment: Alignment.center,
            child: Text(
              (int.parse(item) ~/ 60).toString(),
              style: TextStyle(
                color: double.parse(item) == provider.selectedTime
                    ? AppColors.primary
                    : AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
