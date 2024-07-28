import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // intl paketini içeri aktar
import 'dart:async'; // Timer için gerekli

import '../../../utils/Constant/colors.dart';
import '../../../utils/Helpers/helpers_functions.dart';
import '../../../utils/Theme/custom_theme.dart/text_theme.dart';

class ViScheduleHeaderTime extends StatefulWidget {
  const ViScheduleHeaderTime({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ViScheduleHeaderTimeState createState() => _ViScheduleHeaderTimeState();
}

class _ViScheduleHeaderTimeState extends State<ViScheduleHeaderTime> {
  late Timer _timer;
  String _formattedDate = '';
  String _formattedTime = '';

  @override
  void initState() {
    super.initState();
    _updateTime(); // Initial update
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTime();
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Timer'ı temizleyin
    super.dispose();
  }

  void _updateTime() {
    final now = DateTime.now();
    setState(() {
      _formattedDate = DateFormat('yyyy, MMMM').format(now);
      _formattedTime = DateFormat('hh:mm:ss a').format(now);
    });
  }

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);

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
