// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tido/blocs/main_bloc/main_bloc.dart';
import 'package:tido/common/widget/appbar/home_appbar.dart';
import 'package:tido/common/widget/button/ratio_button.dart';
import 'package:tido/core/routes/routes.dart';
import 'package:tido/utils/Constant/colors.dart';
import 'package:tido/views/home/widget/time_button.dart';
import 'package:tido/views/schedule/widget/schedule_heading_time.dart';
import '../../blocs/auth_blocs/sign_in_bloc/sign_in_bloc.dart';
import '../../blocs/home_bloc/home_bloc.dart';
import '../../blocs/home_bloc/home_event.dart';
import '../../blocs/home_bloc/home_state.dart';
import '../../common/widget/button/create_task_button.dart';
import '../../common/widget/task_tile/calender_task_tile.dart';
import '../../core/locator/locator.dart';
import '../../utils/Constant/sizes.dart';

class ScheduleView extends StatefulWidget {
  const ScheduleView({super.key});

  @override
  _ScheduleViewState createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider.value(value: getIt<HomeBloc>()),
          BlocProvider.value(value: getIt<SignInBloc>()),
        ],
        child: SafeArea(
          child: Scaffold(
            floatingActionButton: const ViCreateTaskButton(),
            appBar: const ViHomeAppBar(
                height: ViSizes.appBarHeigth * 1.5,
                leadingWidget: ViScheduleHeaderTime()),
            body: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return Column(
                  children: [
                    _buildDateSelector(context),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.filteredTasks.length,
                        itemBuilder: (context, index) {
                          final task = state.filteredTasks[index];
                          return CalenderTaskTile(
                            task: task,
                            title: task.title,
                            dateText: task.formattedDate,
                            timerText: task.formattedTaskTime,
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ));
  }

  Widget _buildDateSelector(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });

        // Seçilen güne göre filtreleme işlemi
        context.read<HomeBloc>().add(FilterTasksByDate(selectedDay));
      },
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          setState(() => _calendarFormat = format);
        }
      },
      onPageChanged: (focusedDay) => _focusedDay = focusedDay,
      // Kalan kodlar
    );
  }
}
