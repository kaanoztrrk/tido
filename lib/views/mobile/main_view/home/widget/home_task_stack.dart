import 'package:TiDo/blocs/home_bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../blocs/home_bloc/home_event.dart';
import '../../../../../blocs/theme_bloc/theme_bloc.dart';
import '../../../../../blocs/theme_bloc/theme_state.dart';
import '../../../../../common/layout/swiper_layout.dart';
import '../../../../../common/widget/admob_banner/adMob_banner.dart';
import '../../../../../common/widget/item_tile/task/task_swiper_tile.dart';
import '../../../../../core/l10n/l10n.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../data/models/task_model/task_model.dart';
import '../../../../../utils/Helpers/helpers_functions.dart';
import '../../../../../utils/bottom_sheet/bottom_sheet.dart';
import '../../../../../utils/constant/colors.dart';
import '../../../../../utils/constant/image_strings.dart';
import '../../../../../utils/theme/custom_theme.dart/text_theme.dart';
import '../../../common/empty_view/empty_view.dart';

class HomeStackListWidget extends StatelessWidget {
  const HomeStackListWidget({
    super.key,
    required this.tasksToShow,
  });

  final List<TaskModel> tasksToShow;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: tasksToShow.isEmpty
          ? Stack(
              children: [
                Center(
                  child: ViEmptyScreen(
                    mainAxisAlignment: MainAxisAlignment.start,
                    size: ViHelpersFunctions.screenHeigth(context) * 0.3,
                    image: ViImages.empty_screen_image_1,
                    title: AppLocalizations.of(context)!.no_tasks_found,
                    subTitle:
                        AppLocalizations.of(context)!.no_tasks_found_subTitle,
                  ),
                ),
                const Align(
                  alignment: AlignmentDirectional.bottomStart,
                  child: AdMobBanner(),
                ),
              ],
            )
          : BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, themestate) {
                return Stack(
                  children: [
                    ViSwiperLayout(
                      itemCount: tasksToShow.length,
                      itemBuilder: (context, index) {
                        final task = tasksToShow[index];
                        return ViTaskSwiperTile(
                          timer: task.taskTime != null
                              ? Text(
                                  " ${task.taskTime!.hour}:${task.taskTime!.minute.toString().padLeft(2, '0')}",
                                  style: ViTextTheme.darkTextTheme.titleSmall
                                      ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.dark),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                )
                              : null,
                          title: task.title,
                          onSwipe: () {
                            BlocProvider.of<HomeBloc>(context).add(
                              ChangeCheckBoxEvent(
                                isChecked: !task.isChecked,
                                task: task,
                              ),
                            );
                          },
                          onTap: () {
                            context.push(ViRoutes.task_detail_view,
                                extra: task);
                          },
                          optionTap: () => ViBottomSheet.showOptionBottomSheet(
                            context,
                            onEdit: () {
                              context.push(ViRoutes.task_edit_view,
                                  extra: task);
                            },
                            onDelete: () {
                              BlocProvider.of<HomeBloc>(context)
                                  .add(DeleteToDoEvent(task: task));
                              context.pop();
                            },
                            onMarkAsComplete: () {
                              BlocProvider.of<HomeBloc>(context).add(
                                ChangeCheckBoxEvent(
                                  isChecked: !task.isChecked,
                                  task: task,
                                ),
                              );
                            },
                          ),
                          isCompleted: task.isChecked,
                        );
                      },
                    ),
                    const Align(
                      alignment: AlignmentDirectional.bottomStart,
                      child: AdMobBanner(),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
