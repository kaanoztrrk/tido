// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../common/styles/container_style.dart';
import '../../../common/widget/button/ratio_button.dart';
import '../../../core/l10n/l10n.dart';
import '../../../utils/Constant/colors.dart';
import '../../../utils/Constant/sizes.dart';
import '../../../utils/Helpers/helpers_functions.dart';
import '../../../utils/Theme/custom_theme.dart/text_theme.dart';

class ViDatePicker extends StatefulWidget {
  final Function(DateTime) onDateTimeChanged;
  final String? title;
  final String? subtitle;
  const ViDatePicker({
    super.key,
    required this.onDateTimeChanged,
    this.title,
    this.subtitle,
  });

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
        margin: const EdgeInsets.all(ViSizes.sm / 2),
        padding: const EdgeInsets.all(ViSizes.sm),
        borderRadius: BorderRadius.circular(30),
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ViRotioButton(
              bgColor: Theme.of(context).primaryColor,
              child: const Icon(
                Iconsax.calendar_1,
                color: AppColors.white,
              ),
            ),
            const Spacer(),
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
                            text: widget.title ??
                                "${AppLocalizations.of(context)!.date}\n",
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
                                text: widget.subtitle ??
                                    AppLocalizations.of(context)!.selected,
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
