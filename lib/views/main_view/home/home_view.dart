import 'dart:async';

import 'package:TiDo/common/styles/container_style.dart';
import 'package:TiDo/utils/Device/device_utility.dart';
import 'package:TiDo/utils/bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:workmanager/workmanager.dart';

import '../../../blocs/auth_blocs/sign_in_bloc/sign_in_bloc.dart';
import '../../../blocs/home_bloc/home_bloc.dart';
import '../../../blocs/home_bloc/home_event.dart';
import '../../../blocs/home_bloc/home_state.dart';
import '../../../blocs/theme_bloc/theme_bloc.dart';
import '../../../blocs/theme_bloc/theme_state.dart';

import '../../../data/services/google_ads_service.dart';
import '../../common/empty_view/empty_view.dart';
import '../../../common/layout/swiper_layout.dart';
import '../../../common/widget/admob_banner/adMob_banner.dart';
import '../../../common/widget/appbar/home_appbar.dart';
import '../../../common/widget/button/ratio_button.dart';

import '../../../common/widget/item_tile/task_tile.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/locator/locator.dart';
import '../../../core/routes/routes.dart';
import '../../../data/models/task_model/task_model.dart';
import '../../../utils/Constant/colors.dart';
import '../../../utils/Constant/image_strings.dart';
import '../../../utils/Constant/sizes.dart';
import '../../../utils/Helpers/helpers_functions.dart';
import '../../../utils/Theme/custom_theme.dart/text_theme.dart';
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
              notificationOnPressed: () {
                // context.push(ViRoutes.notification_page);
                Workmanager().registerOneOffTask("Task one", "backup",
                    initialDelay: Duration(seconds: 5));
              }),
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, homestate) {
              List<TaskModel> tasksToShow = homestate.allTasksList;
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
                          child: ListView(
                            padding: const EdgeInsets.only(left: 10),
                            scrollDirection: Axis.horizontal,
                            children: [
                              ViContainer(
                                width:
                                    ViDeviceUtils.getScreenWidth(context) * 0.2,
                                height: ViDeviceUtils.getScreenHeigth(context) *
                                    0.1,
                                borderRadius: BorderRadius.circular(
                                    ViSizes.cardRadiusLg * 2),
                                bgColor: Theme.of(context).primaryColor,
                                child: Center(
                                    child: Text(
                                  "All (${homestate.allTasksList.length})",
                                  style: ViTextTheme.darkTextTheme.bodyLarge
                                      ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.light),
                                )),
                              )
                            ],
                          ),
                        ),
                      ),

                      //* Search Button
                      ViRotioButton(
                        onTap: () {
                          // Diğer sayfaya geçiş

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
                        ? Stack(
                            children: [
                              Center(
                                child: ViEmptyScreen(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  size:
                                      ViHelpersFunctions.screenHeigth(context) *
                                          0.3,
                                  image: ViImages.empty_screen_image_1,
                                  title: AppLocalizations.of(context)!
                                      .no_tasks_found,
                                  subTitle: AppLocalizations.of(context)!
                                      .no_tasks_found_subTitle,
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
                                                style: ViTextTheme
                                                    .darkTextTheme.titleSmall
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: AppColors.dark),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              )
                                            : null,
                                        title: task.title,
                                        onSwipe: () {
                                          BlocProvider.of<HomeBloc>(context)
                                              .add(
                                            ChangeCheckBoxEvent(
                                              isChecked: !task.isChecked,
                                              task: task,
                                            ),
                                          );
                                        },
                                        onTap: () {
                                          context.push(
                                              ViRoutes.task_detail_view,
                                              extra: task);
                                        },
                                        optionTap: () =>
                                            ViBottomSheet.showOptionBottomSheet(
                                          context,
                                          onEdit: () {
                                            context.push(
                                                ViRoutes.task_edit_view,
                                                extra: task);
                                          },
                                          onDelete: () {
                                            BlocProvider.of<HomeBloc>(context)
                                                .add(DeleteToDoEvent(
                                                    task: task));
                                            context.pop();
                                          },
                                          onMarkAsComplete: () {
                                            BlocProvider.of<HomeBloc>(context)
                                                .add(
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
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}


/*
  : ListView.builder(
                                      itemCount: homestate.allTasksList.length +
                                          1, // Banner için +1 ekledik
                                      itemBuilder: (context, index) {
                                        if (index == 0) {
                                          // Listenin başına reklam ekleme
                                          return SizedBox(
                                            height: 80  , // Reklamın yüksekliği
                                            child: AdWidget(
                                              ad: GoogleAdsService()
                                                  .loadBannerAd()!,
                                            ),
                                          );
                                        }
                                        final task = tasksToShow[index -
                                            1]; // Banner'ı hesaba katarak index kaydırıldı
                                        return ViTaskListTile(
                                          task: task,
                                          onTap: () {
                                            context.push(
                                                ViRoutes.task_detail_view,
                                                extra: task);
                                          },
                                          optionTap: () => ViBottomSheet
                                              .showOptionBottomSheet(
                                            context,
                                            onEdit: () {
                                              context.push(
                                                  ViRoutes.task_edit_view,
                                                  extra: task);
                                            },
                                            onDelete: () {
                                              BlocProvider.of<HomeBloc>(context)
                                                  .add(DeleteToDoEvent(
                                                      task: task));
                                              context.pop();
                                            },
                                            onMarkAsComplete: () {
                                              BlocProvider.of<HomeBloc>(context)
                                                  .add(
                                                ChangeCheckBoxEvent(
                                                  isChecked: !task.isChecked,
                                                  task: task,
                                                ),
                                              );
                                            },
                                          ),
                                          title: task.title,
                                          files: task.files!.length.toString(),
                                          dueTime: task.taskTime != null
                                              ? Text(
                                                  "${task.taskTime!.day} ${DateFormat('MMM').format(task.taskTime!)} ${task.taskTime!.year}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                )
                                              : null,
                                          description:
                                              task.description.toString(),
                                        );
                                      }); */