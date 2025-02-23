// ignore_for_file: library_private_types_in_public_api

import 'package:TiDo/common/widget/appbar/appbar.dart';
import 'package:TiDo/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../blocs/auth_blocs/sign_in_bloc/sign_in_bloc.dart';
import '../../../blocs/home_bloc/home_bloc.dart';
import '../../../blocs/home_bloc/home_event.dart';
import '../../../blocs/home_bloc/home_state.dart';
import '../../../common/widget/appbar/home_appbar.dart';
import '../../../common/widget/button/create_button.dart';
import '../../../common/widget/item_tile/calender_task_tile.dart';
import '../../../core/locator/locator.dart';
import '../../../data/services/date_formetter_service.dart';

import '../../../utils/Constant/image_strings.dart';
import '../../../utils/Constant/sizes.dart';

import '../../common/empty_view/empty_view.dart';
import '../../../utils/Helpers/helpers_functions.dart';
import 'widget/schedule_heading_time.dart';

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
            floatingActionButton: ViCreateButton(
              icon: Iconsax.add,
              onTap: () => context.push(ViRoutes.create_task),
            ),
            appBar: const ViHomeAppBar(
                height: ViSizes.appBarHeigth * 1.5,
                leadingWidget: ViScheduleHeaderTime()),
            body: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                final hasTasks = state.filteredTasks.isNotEmpty;

                return Column(
                  children: [
                    _buildDateSelector(context),
                    Expanded(
                      child: hasTasks
                          ? ListView.builder(
                              itemCount: state.filteredTasks.length,
                              itemBuilder: (context, index) {
                                final task = state.filteredTasks[index];
                                return CalenderTaskTile(
                                  task: task,
                                  title: task.title,
                                  dateText: task.formattedTaskTime(
                                      DateFormatterService(context)),
                                  timerText: task.formattedDate(
                                      DateFormatterService(context)),
                                );
                              },
                            )
                          : Stack(
                              children: [
                                Center(
                                  child: ViEmptyScreen(
                                    size: ViHelpersFunctions.screenHeigth(
                                            context) *
                                        0.3,
                                    image: ViImages.empty_screen_image_1,
                                    title: 'No Tasks Found',
                                    subTitle:
                                        'There are no tasks for the selected date.',
                                  ),
                                ),
                              ],
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
    final locale = Localizations.localeOf(context).toString();

    return TableCalendar(
      locale: locale,
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: _focusedDay,
      calendarFormat: CalendarFormat.week,
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
      calendarStyle: CalendarStyle(
        selectedDecoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withValues(alpha: 0.4),
          shape: BoxShape.circle,
        ),
      ),
      headerStyle: HeaderStyle(
        titleTextStyle: TextStyle(color: Theme.of(context).primaryColor),
        formatButtonDecoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        formatButtonTextStyle: const TextStyle(color: Colors.white),
        leftChevronIcon: Icon(
          Icons.chevron_left,
          color: Theme.of(context).primaryColor,
        ),
        rightChevronIcon: Icon(
          Icons.chevron_right,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
