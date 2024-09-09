import 'package:flutter/material.dart';

class PomodoroSettings extends StatelessWidget {
  const PomodoroSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


/*
import 'package:TiDo/common/bottom_sheet/change_language_bottom_sheet.dart';
import 'package:TiDo/common/widget/button/primary_button.dart';
import 'package:TiDo/core/l10n/l10n.dart';
import 'package:TiDo/data/services/shared_preferences_service.dart';
import 'package:TiDo/utils/Snackbar/snacbar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../blocs/pomodor_bloc/pomodor_bloc.dart';
import '../../../blocs/pomodor_bloc/pomodor_event.dart';
import '../../../blocs/pomodor_bloc/pomodor_state.dart';
import '../../../common/widget/appbar/appbar.dart';
import '../../../common/widget/task_tile/settings_tile.dart';

class PomodoroSettings extends StatefulWidget {
  const PomodoroSettings({super.key});

  @override
  State<PomodoroSettings> createState() => _PomodoroSettingsState();
}

class _PomodoroSettingsState extends State<PomodoroSettings> {
  late String focusTime;
  late String shortBreak;
  late String longBreak;
  late String intervals;

  @override
  void initState() {
    super.initState();
    // Initialize with default values from BLoC state
    focusTime = '25 min';
    shortBreak = '5 min';
    longBreak = '15 min';
    intervals = '4 intervals';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ViAppBar(
        showBackArrow: true,
        title: Text("Pomodoro Settings"),
        centerTitle: true,
      ),
      body: BlocBuilder<PomodorBloc, PomodoroState>(
        builder: (context, state) {
          // Update dropdown values based on BLoC state
          if (focusTime == '20 min' && state.focusTimes.isNotEmpty) {
            focusTime = state.focusTimes.first;
          }
          if (shortBreak == '5 min' && state.shortBreaks.isNotEmpty) {
            shortBreak = state.shortBreaks.first;
          }
          if (longBreak == '15 min' && state.longBreaks.isNotEmpty) {
            longBreak = state.longBreaks.first;
          }
          if (intervals == '4 intervals' && state.sections.isNotEmpty) {
            intervals = state.sections.first;
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Focus time custom dropdown
                SettingsTile(
                  label: 'Focus Time',
                  value: focusTime,
                  items: state.focusTimes,
                  onChanged: (newValue) {
                    setState(() {
                      focusTime = newValue!;
                    });
                  },
                ),
                const SizedBox(height: 16),

                // Short break custom dropdown
                SettingsTile(
                  label: 'Short Break',
                  value: shortBreak,
                  items: state.shortBreaks,
                  onChanged: (newValue) {
                    setState(() {
                      shortBreak = newValue!;
                    });
                  },
                ),
                const SizedBox(height: 16),

                // Long break custom dropdown
                SettingsTile(
                  label: 'Long Break',
                  value: longBreak,
                  items: state.longBreaks,
                  onChanged: (newValue) {
                    setState(() {
                      longBreak = newValue!;
                    });
                  },
                ),
                const SizedBox(height: 16),

                // Sections custom dropdown
                SettingsTile(
                  label: 'Intervals',
                  value: intervals,
                  items: state.sections,
                  onChanged: (newValue) {
                    setState(() {
                      intervals = newValue!;
                    });
                  },
                ),

                const Spacer(),

                // Save and Cancel buttons
                ViPrimaryButton(
                  text: AppLocalizations.of(context)!.done,
                  onTap: () async {
                    // Ayarları kaydet
                    await SharedPreferencesService.instance
                        .savePomodoroSettings(
                      focusTime: int.parse(focusTime.split(' ')[0]) * 60,
                      shortBreakTime: int.parse(shortBreak.split(' ')[0]) * 60,
                      longBreakTime: int.parse(longBreak.split(' ')[0]) * 60,
                      intervals: intervals,
                    );

                    // Ayarları BLoC'a gönder
                    context.read<PomodorBloc>().add(
                          PomodorSetFocusTimeEvent(
                            int.parse(focusTime.split(' ')[0]) * 60,
                          ),
                        );
                    context.read<PomodorBloc>().add(
                          PomodorSetBreakTimeEvent(
                            int.parse(shortBreak.split(' ')[0]) * 60,
                          ),
                        );

                    ViSnackbar.showSuccess(context, "Settings saved!");
                    context.pop();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}


 */