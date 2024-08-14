import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tido/blocs/home_bloc/home_event.dart';

import 'package:tido/common/bottom_sheet/task_option_bottom_sheet.dart';
import 'package:tido/common/empty_screen/empty_screen.dart';
import 'package:tido/common/layout/swiper_layout.dart';
import 'package:tido/common/widget/chip/category_chip.dart';
import 'package:tido/core/l10n/l10n.dart';
import 'package:tido/core/routes/routes.dart';
import 'package:tido/utils/Constant/colors.dart';
import 'package:tido/utils/Constant/image_strings.dart';
import 'package:tido/utils/Constant/sizes.dart';
import 'package:tido/utils/Theme/custom_theme.dart/text_theme.dart';
import '../../blocs/auth_blocs/sign_in_bloc/sign_in_bloc.dart';
import '../../blocs/home_bloc/home_bloc.dart';
import '../../blocs/home_bloc/home_state.dart';
import '../../common/widget/appbar/home_appbar.dart';
import '../../common/widget/button/ratio_button.dart';
import '../../common/widget/task_tile/main_task_tile.dart';
import '../../core/locator/locator.dart';
import '../../data/models/task_model/task_model.dart';
import '../../utils/Helpers/helpers_functions.dart';
import 'widget/home_header.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    return MultiBlocProvider(
        providers: [
          BlocProvider.value(value: getIt<HomeBloc>()),
          BlocProvider.value(value: getIt<SignInBloc>())
        ],
        child: SafeArea(
          child: Scaffold(
            //* Appbar
            appBar: ViHomeAppBar(
              createTaskButton: true,
              height: ViSizes.appBarHeigth * 1.5,
              leadingOnPressed: () => context.push(ViRoutes.create_task),
              notificationOnPressed: () =>
                  context.push(ViRoutes.notification_page),
            ),
            body: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                List<TaskModel> tasksToShow = state.allTasksList;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //* Home Header
                    const Padding(
                        padding: EdgeInsets.all(ViSizes.defaultSpace),
                        child: HomeHeader()),
                    const SizedBox(height: ViSizes.spaceBtwItems),
                    //* Category
                    Row(
                      children: [
                        //* Category List
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: ListView.builder(
                              padding: const EdgeInsets.only(left: 10),
                              scrollDirection: Axis.horizontal,
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                if (index == 0 &&
                                    state.allCategoryList.isNotEmpty) {
                                  final category = state.allCategoryList[0];
                                  return ViCategoryChip(
                                      category: category, state: state);
                                } else {
                                  return const SizedBox
                                      .shrink(); // diğer indexler için boş bir widget döndür
                                }
                              },
                            ),
                          ),
                        ),

                        //* Search Button
                        ViRotioButton(
                          onTap: () {
                            context.push(ViRoutes.search_view);
                          },
                          child: Icon(
                            Iconsax.search_normal,
                            color: dark ? AppColors.light : AppColors.dark,
                          ),
                        ),
                        const SizedBox(width: ViSizes.sm),
                      ],
                    ),

                    //* Task List
                    Expanded(
                      child: tasksToShow.isEmpty
                          ? ViEmptyScreen(
                              image: ViImages.empty_screen_image_1,
                              title:
                                  AppLocalizations.of(context)!.no_tasks_found,
                              subTitle: AppLocalizations.of(context)!
                                  .no_tasks_found_subTitle,
                            )
                          : ViSwiperLayout(
                              itemCount: tasksToShow.length,
                              itemBuilder: (context, index) {
                                final task = tasksToShow[index];
                                return HomeMainTaskTile(
                                  timer: task.taskTime != null
                                      ? Text(
                                          "${task.taskTime!.hour}:${task.taskTime!.minute.toString().padLeft(2, '0')}",
                                          style: dark
                                              ? ViTextTheme
                                                  .ligthTextTheme.titleSmall
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w600)
                                              : ViTextTheme
                                                  .darkTextTheme.titleSmall
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w600),
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
                                  optionTap: () => ViOptionBottomSheet()
                                      .showOptionBottomSheet(
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
                    ),
                  ],
                );
              },
            ),
          ),
        ));
  }
}
