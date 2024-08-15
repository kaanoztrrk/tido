import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/l10n/l10n.dart';
import '../../../utils/Constant/colors.dart';
import '../../../utils/Helpers/helpers_functions.dart';
import '../../../utils/Theme/custom_theme.dart/text_theme.dart';

class ViScheduleHeaderTime extends StatefulWidget {
  const ViScheduleHeaderTime({super.key});

  @override
  _ViScheduleHeaderTimeState createState() => _ViScheduleHeaderTimeState();
}

class _ViScheduleHeaderTimeState extends State<ViScheduleHeaderTime> {
  late Timer _timer;
  String _formattedDate = '';
  String _formattedTime = '';

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTime();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateTime(); // Ensure correct time format after dependencies change
  }

  @override
  void dispose() {
    _timer.cancel(); // Clean up the timer
    super.dispose();
  }

  void _updateTime() {
    final now = DateTime.now();
    final locale =
        Localizations.localeOf(context).toString(); // Get the current locale
    setState(() {
      _formattedDate =
          DateFormat.yMMMM(locale).format(now); // Format date based on locale
      _formattedTime = DateFormat('HH:mm:ss', locale)
          .format(now); // Format time based on locale
    });
  }

  @override
  Widget build(BuildContext context) {
    final dark = ViHelpersFunctions.isDarkMode(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _formattedDate,
          style: dark
              ? ViTextTheme.darkTextTheme.headlineMedium?.copyWith(
                  color: AppColors.white, fontWeight: FontWeight.bold)
              : ViTextTheme.ligthTextTheme.headlineMedium?.copyWith(
                  color: AppColors.primaryText, fontWeight: FontWeight.bold),
        ),
        Text(
          _formattedTime,
          style: dark
              ? ViTextTheme.darkTextTheme.titleLarge
                  ?.copyWith(color: AppColors.white)
              : ViTextTheme.ligthTextTheme.titleLarge
                  ?.copyWith(color: AppColors.secondaryText),
        ),
      ],
    );
  }
}
