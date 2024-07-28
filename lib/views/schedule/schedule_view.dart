import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tido/common/widget/appbar/home_appbar.dart';
import 'package:tido/utils/Constant/colors.dart';
import 'package:tido/views/schedule/widget/schedule_heading_time.dart';
import '../../blocs/home_bloc/home_bloc.dart';
import '../../blocs/home_bloc/home_event.dart';
import '../../blocs/home_bloc/home_state.dart';
import '../../common/widget/task_tile/calender_task_tile.dart';
import '../../utils/Constant/sizes.dart';

class ScheduleView extends StatefulWidget {
  @override
  _ScheduleViewState createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const ViHomeAppBar(
            height: ViSizes.appBarHeigth * 2,
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
                        title: task.title,
                        dateText: DateFormat.MMMM('en_US')
                            .add_d()
                            .format(task.taskTime ?? DateTime.now()),
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
    );
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
        context.read<HomeBloc>().add(FilterTasksByDate(selectedDay));
      },
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          setState(() => _calendarFormat = format);
        }
      },
      onPageChanged: (focusedDay) => _focusedDay = focusedDay,

      // Özelleştirme
      headerStyle: HeaderStyle(
        titleTextStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primary),
        formatButtonVisible: true,
        leftChevronIcon:
            const Icon(Icons.chevron_left, color: AppColors.primary),
        rightChevronIcon:
            const Icon(Icons.chevron_right, color: AppColors.primary),
        decoration: BoxDecoration(
          color: Colors.grey[200],
        ),
      ),
      calendarStyle: const CalendarStyle(
        isTodayHighlighted: true,
        selectedDecoration: BoxDecoration(
          color: AppColors.darkgrey,
          shape: BoxShape.circle,
        ),
        selectedTextStyle: TextStyle(color: Colors.white),
        todayDecoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        todayTextStyle: TextStyle(color: Colors.white),
        outsideDecoration: BoxDecoration(
          color: Colors.transparent,
        ),
        outsideTextStyle: TextStyle(color: Colors.grey),
      ),
    );
  }
}
