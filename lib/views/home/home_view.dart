import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tido/blocs/home_bloc/home_event.dart';
import 'package:tido/common/bottom_sheet/task_detail_bottom_sheet.dart';
import 'package:tido/common/layout/swiper_layout.dart';
import 'package:tido/common/styles/container_style.dart';
import 'package:tido/core/routes/routes.dart';
import 'package:tido/utils/Constant/colors.dart';
import 'package:tido/utils/Constant/sizes.dart';
import 'package:tido/utils/Theme/custom_theme.dart/text_theme.dart';
import '../../blocs/home_bloc/home_bloc.dart';
import '../../blocs/home_bloc/home_state.dart';
import '../../common/widget/appbar/home_appbar.dart';
import '../../common/widget/task_tile/main_task_tile.dart';
import '../../data/models/task_model/task_model.dart';
import 'widget/home_header.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final ViTaskOptionBottomSheet _bottomSheet = ViTaskOptionBottomSheet();

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        List<TaskModel> tasksToShow;
        switch (state.taskCategoryIndex) {
          case 1:
            tasksToShow = state.todayTasksList;
            break;
          case 2:
            tasksToShow = state.weeklyTasksList;
            break;
          default:
            tasksToShow = state.allTasksList;
            break;
        }
        return SafeArea(
            child: Scaffold(
          appBar: ViHomeAppBar(
            createTaskButton: true,
            height: ViSizes.appBarHeigth * 1.5,
            leadingOnPressed: () => context.push(ViRoutes.create_task),
            notificationOnPressed: () {
              print("object");
            },
            remainingTime: state.remainingTime,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(ViSizes.defaultSpace),
                child: HomeHeader(name: "Kaan"),
              ),
              const SizedBox(height: ViSizes.spaceBtwItems),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 10),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.taskCategoryList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        BlocProvider.of<HomeBloc>(context)
                            .add(CategoryUpdateTab(index));
                      },
                      child: ViContainer(
                        bgColor: state.taskCategoryIndex == index
                            ? AppColors.primary
                            : AppColors.ligthGrey,
                        margin: const EdgeInsets.only(right: ViSizes.sm),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        borderRadius: BorderRadius.circular(50),
                        child: Center(
                          child: Text(
                            "${state.taskCategoryList[index]} (${state.getTaskCount(index)})",
                            style: state.taskCategoryIndex == index
                                ? ViTextTheme.darkTextTheme.titleSmall
                                : ViTextTheme.ligthTextTheme.titleSmall,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: tasksToShow.isEmpty
                    ? Center(
                        child: Text(
                          'No tasks available',
                          style: ViTextTheme.ligthTextTheme.titleMedium,
                        ),
                      )
                    : ViSwiperLayout(
                        itemCount: tasksToShow.length,
                        itemBuilder: (context, index) {
                          final task = tasksToShow[index];
                          return HomeMainTaskTile(
                            timer: task.taskTime.toString(),
                            title: task.title,
                            onSwipe: () {
                              BlocProvider.of<HomeBloc>(context).add(
                                ChangeCheckBoxEvent(
                                  isChecked: !task.isChecked,
                                  task: task,
                                ),
                              );
                            },
                            onTap: () => _bottomSheet.showOptionBottomSheet(
                              context,
                              onEdit: () {
                                // Düzenleme işlemi
                                print('Düzenle tıklandı');
                                // Burada düzenleme ekranına yönlendirme veya düzenleme işlemi yapılabilir
                              },
                              onDelete: () {
                                // Silme işlemi
                                print('Sil tıklandı');
                                // Burada silme işlemi yapılabilir
                              },
                              onMarkAsComplete: () {
                                // Tamamlandı olarak işaretleme işlemi
                                print('Tamamlandı olarak işaretle tıklandı');
                                // Burada tamamlandı olarak işaretleme işlemi yapılabilir
                              },
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ));
      },
    );
  }
}
