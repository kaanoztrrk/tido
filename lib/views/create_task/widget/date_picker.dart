import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tido/common/styles/container_style.dart';
import 'package:tido/utils/Helpers/helpers_functions.dart';

import '../../../common/widget/button/ratio_button.dart';
import '../../../utils/Constant/colors.dart';
import '../../../utils/Constant/sizes.dart';
import '../../../utils/Theme/custom_theme.dart/text_theme.dart';

class ViDatePicker extends StatefulWidget {
  final Function(DateTime) onDateTimeChanged;

  const ViDatePicker({Key? key, required this.onDateTimeChanged})
      : super(key: key);

  @override
  _ViDatePickerState createState() => _ViDatePickerState();
}

class _ViDatePickerState extends State<ViDatePicker> {
  DateTime? _selectedDateTime;

  Future<void> _pickDateTime() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (date != null) {
      TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (time != null) {
        final DateTime dateTime = DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );
        setState(() {
          _selectedDateTime = dateTime;
        });
        widget.onDateTimeChanged(dateTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: _pickDateTime,
      child: ViContainer(
        margin: EdgeInsets.all(ViSizes.sm / 2),
        padding: EdgeInsets.all(ViSizes.sm),
        borderRadius: BorderRadius.circular(30),
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ViRotioButton(
              bgColor: AppColors.primary,
              child: Icon(
                Iconsax.calendar_1,
                color: AppColors.white,
              ),
            ),
            Spacer(),
            Row(
              children: [
                _selectedDateTime != null
                    ? Padding(
                        padding: const EdgeInsets.all(ViSizes.sm),
                        child: Text.rich(TextSpan(
                            text:
                                "${_selectedDateTime!.hour}:${_selectedDateTime!.minute.toString().padLeft(2, '0')}\n",
                            style: dark
                                ? ViTextTheme.darkTextTheme.headlineLarge
                                    ?.copyWith(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.bold)
                                : ViTextTheme.ligthTextTheme.headlineLarge
                                    ?.copyWith(
                                        color: AppColors.primaryText,
                                        fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text:
                                    "${_selectedDateTime!.day}/${_selectedDateTime!.month}/${_selectedDateTime!.year}",
                                style: dark
                                    ? ViTextTheme.darkTextTheme.titleLarge
                                        ?.copyWith(
                                            color: AppColors.secondaryText)
                                    : ViTextTheme.ligthTextTheme.titleLarge
                                        ?.copyWith(
                                            color: AppColors.secondaryText),
                              )
                            ])),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(ViSizes.sm),
                        child: Text.rich(TextSpan(
                            text: "Selected\n",
                            style: dark
                                ? ViTextTheme.darkTextTheme.headlineMedium
                                    ?.copyWith(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.bold)
                                : ViTextTheme.ligthTextTheme.headlineMedium
                                    ?.copyWith(
                                        color: AppColors.primaryText,
                                        fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: "Date & Time",
                                style: dark
                                    ? ViTextTheme.darkTextTheme.titleLarge
                                        ?.copyWith(
                                            color: AppColors.secondaryText)
                                    : ViTextTheme.ligthTextTheme.titleLarge
                                        ?.copyWith(
                                            color: AppColors.secondaryText),
                              )
                            ])),
                      )
              ],
            )
          ],
        ),
      ),
    );
  }
}
