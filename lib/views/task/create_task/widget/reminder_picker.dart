// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../blocs/home_bloc/home_bloc.dart';
import '../../../../blocs/home_bloc/home_event.dart';
import '../../../../common/widget/button/ratio_button.dart';
import '../../../../utils/Constant/colors.dart';
import '../../../../utils/Helpers/helpers_functions.dart';
import '../../../../utils/Theme/custom_theme.dart/text_theme.dart';

class ViReminderButton extends StatefulWidget {
  final IconData icon;
  final Duration? selectedReminder;
  final ValueChanged<Duration?> onReminderSelected;
  final bool isActive;

  const ViReminderButton({
    super.key,
    required this.icon,
    this.selectedReminder,
    required this.onReminderSelected,
    required this.isActive,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ViReminderButtonState createState() => _ViReminderButtonState();
}

class _ViReminderButtonState extends State<ViReminderButton> {
  Duration? reminderDuration;
  final List<Map<String, Duration>> reminderOptions = [
    {'5 minutes before': const Duration(minutes: 5)},
    {'10 minutes before': const Duration(minutes: 10)},
    {'15 minutes before': const Duration(minutes: 15)},
    {'30 minutes before': const Duration(minutes: 30)},
    {'1 hour before': const Duration(hours: 1)},
    {'2 hours before': const Duration(hours: 2)},
  ];

  void _openReminderBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        var dark = ViHelpersFunctions.isDarkMode(context);
        return Container(
          decoration: BoxDecoration(
            color: dark ? AppColors.black : AppColors.white,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: reminderOptions.map((option) {
              var entry = option.entries.first;
              return ListTile(
                title: Text(
                  entry.key,
                  style: dark
                      ? ViTextTheme.darkTextTheme.titleLarge
                          ?.copyWith(color: AppColors.white)
                      : ViTextTheme.ligthTextTheme.titleLarge
                          ?.copyWith(color: AppColors.black),
                ),
                onTap: () async {
                  setState(() {
                    reminderDuration = entry.value;
                  });
                  widget.onReminderSelected(entry.value);
                  BlocProvider.of<HomeBloc>(context)
                      .add(ReminderSelected(entry.value));
                  // Await Navigator.pop to ensure UI updates and modal closes
                  await Future.delayed(const Duration(milliseconds: 200));
                  context.pop();
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () {
        if (widget.isActive) {
          _openReminderBottomSheet(context);
        }
      },
      child: widget.selectedReminder == null
          ? ViRotioButton(
              onTap: () {
                if (widget.isActive) {
                  _openReminderBottomSheet(context);
                }
              },
              child: Icon(
                widget.icon,
                color:
                    widget.isActive ? AppColors.white : AppColors.primaryText,
              ),
            )
          : Container(
              decoration: BoxDecoration(
                color: widget.isActive
                    ? Theme.of(context).primaryColor
                    : AppColors.lightGrey,
                borderRadius: BorderRadius.circular(50),
              ),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Row(
                children: [
                  ViRotioButton(
                    onTap: () {
                      if (widget.isActive) {
                        _openReminderBottomSheet(context);
                      }
                    },
                    child: Icon(
                      widget.icon,
                      color: widget.isActive
                          ? AppColors.white
                          : AppColors.primaryText,
                    ),
                  ),
                  if (widget.isActive && reminderDuration != null) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        '${reminderDuration!.inMinutes} minutes before',
                        style: dark
                            ? ViTextTheme.darkTextTheme.titleLarge
                                ?.copyWith(color: AppColors.white)
                            : ViTextTheme.ligthTextTheme.titleLarge
                                ?.copyWith(color: AppColors.primaryText),
                      ),
                    ),
                  ],
                ],
              ),
            ),
    );
  }
}
