import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart' as picker;
import 'package:flutter_datetime_picker/src/datetime_picker_theme.dart'
    as picker_theme;

import '../../../../../blocs/localization_bloc/localization_bloc.dart';
import '../../../../../common/styles/container_style.dart';
import '../../../../../common/widget/button/ratio_button.dart';
import '../../../../../core/l10n/l10n.dart';
import '../../../../../utils/Constant/colors.dart';
import '../../../../../utils/Constant/sizes.dart';
import '../../../../../utils/Snackbar/snacbar_service.dart';
import '../../../../../utils/Theme/custom_theme.dart/text_theme.dart';

class ViDateTimePicker extends StatefulWidget {
  final bool dark;
  final DateTime? initialDateTime;
  final ValueChanged<DateTime> onDateSelected;

  const ViDateTimePicker({
    Key? key,
    required this.dark,
    this.initialDateTime,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  _ViDateTimePickerState createState() => _ViDateTimePickerState();
}

class _ViDateTimePickerState extends State<ViDateTimePicker> {
  DateTime? _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _selectedDateTime = widget.initialDateTime;
  }

  void _pickDateTime() async {
    final localizationState = context.read<LocalizationBloc>().state;
    final currentLocale = localizationState.selectedLanguage.locale;

    await picker.DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      onConfirm: (date) {
        if (date.isBefore(DateTime.now())) {
          ViSnackbar.showError(context, "Please select a future date.");
        } else {
          setState(() {
            _selectedDateTime = date;
          });
          widget.onDateSelected(date);
        }
      },
      currentTime: DateTime.now().add(const Duration(minutes: 1)),
      locale: currentLocale.languageCode == 'en'
          ? picker.LocaleType.en
          : picker.LocaleType.tr,
      theme: picker_theme.DatePickerTheme(
        backgroundColor: widget.dark ? AppColors.dark : AppColors.light,
        itemStyle: TextStyle(
          color: widget.dark ? AppColors.light : AppColors.dark,
        ),
        cancelStyle: TextStyle(
          color: widget.dark ? AppColors.light : AppColors.dark,
        ),
        doneStyle: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                        child: Text.rich(
                          TextSpan(
                            text:
                                "\${_selectedDateTime!.hour}:\${_selectedDateTime!.minute.toString().padLeft(2, '0')}\n",
                            style: widget.dark
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
                                    "\${_selectedDateTime!.day}/\${_selectedDateTime!.month}/\${_selectedDateTime!.year}",
                                style: widget.dark
                                    ? ViTextTheme.darkTextTheme.titleLarge
                                        ?.copyWith(
                                            color: AppColors.secondaryText)
                                    : ViTextTheme.ligthTextTheme.titleLarge
                                        ?.copyWith(
                                            color: AppColors.secondaryText),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(ViSizes.sm),
                        child: Text.rich(
                          TextSpan(
                            text: "\${AppLocalizations.of(context)!.date}\n",
                            style: widget.dark
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
                                text: AppLocalizations.of(context)!.selected,
                                style: widget.dark
                                    ? ViTextTheme.darkTextTheme.titleLarge
                                        ?.copyWith(
                                            color: AppColors.secondaryText)
                                    : ViTextTheme.ligthTextTheme.titleLarge
                                        ?.copyWith(
                                            color: AppColors.secondaryText),
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
