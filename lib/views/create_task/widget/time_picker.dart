import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tido/common/widget/button/ratio_button.dart';
import 'package:tido/utils/Constant/colors.dart';
import 'package:tido/utils/Helpers/helpers_functions.dart';

import '../../../blocs/home_bloc/home_bloc.dart';
import '../../../blocs/home_bloc/home_event.dart';
import '../../../utils/Constant/sizes.dart';
import '../../../utils/Theme/custom_theme.dart/text_theme.dart';

class ViTimePicker extends StatefulWidget {
  final IconData icon;
  final TimeOfDay? selectedTime;
  final bool isActive;
  final ValueChanged<TimeOfDay?> onTimeSelected;

  const ViTimePicker({
    Key? key,
    required this.icon,
    this.selectedTime,
    required this.isActive,
    required this.onTimeSelected,
  }) : super(key: key);

  @override
  _ViTimePickerState createState() => _ViTimePickerState();
}

class _ViTimePickerState extends State<ViTimePicker> {
  late String timeText;
  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();
    selectedTime = widget.selectedTime;
    timeText = selectedTime != null
        ? '${selectedTime!.hour}:${selectedTime!.minute}'
        : 'Select Time';
  }

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: widget.isActive
          ? () async {
              final TimeOfDay? picked = await showTimePicker(
                context: context,
                initialTime: selectedTime ?? TimeOfDay.now(),
              );
              if (picked != null) {
                widget.onTimeSelected(picked);
              }
            }
          : null,
      child: selectedTime == null
          ? ViRotioButton(
              child: Icon(widget.icon),
            )
          : Container(
              margin: const EdgeInsets.only(bottom: ViSizes.sm),
              decoration: BoxDecoration(
                color: widget.isActive ? AppColors.white : AppColors.primary,
                borderRadius: BorderRadius.circular(50),
              ),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Row(
                children: [
                  ViRotioButton(
                    child: Icon(widget.icon),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      timeText,
                      style: dark
                          ? ViTextTheme.darkTextTheme.titleLarge
                              ?.copyWith(color: AppColors.white)
                          : ViTextTheme.ligthTextTheme.titleLarge
                              ?.copyWith(color: AppColors.white),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
