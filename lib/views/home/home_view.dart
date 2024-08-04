import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tido/blocs/home_bloc/home_event.dart';
import 'package:tido/common/bottom_sheet/add_category_bottom_sheet.dart';
import 'package:tido/common/bottom_sheet/task_option_bottom_sheet.dart';
import 'package:tido/common/empty_screen/empty_screen.dart';
import 'package:tido/common/layout/swiper_layout.dart';
import 'package:tido/common/styles/container_style.dart';
import 'package:tido/core/routes/routes.dart';
import 'package:tido/utils/Constant/colors.dart';
import 'package:tido/utils/Constant/image_strings.dart';
import 'package:tido/utils/Constant/sizes.dart';
import 'package:tido/utils/Theme/custom_theme.dart/text_theme.dart';
import '../../blocs/auth_blocs/sign_in_bloc/sign_in_bloc.dart';
import '../../blocs/home_bloc/home_bloc.dart';
import '../../blocs/home_bloc/home_state.dart';
import '../../common/bottom_sheet/edit_task_bottom_sheet.dart';
import '../../common/widget/appbar/home_appbar.dart';
import '../../common/widget/button/ratio_button.dart';
import '../../common/widget/task_tile/main_task_tile.dart';
import '../../core/locator/locator.dart';
import '../../data/models/task_model/task_model.dart';
import '../../utils/Helpers/helpers_functions.dart';
import 'widget/category_list.dart';
import 'widget/home_header.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    final TextEditingController controller = TextEditingController();
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
                    const Padding(
                        padding: EdgeInsets.all(ViSizes.defaultSpace),
                        child: HomeHeader()),
                    const SizedBox(height: ViSizes.spaceBtwItems),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: ListView.builder(
                              padding: const EdgeInsets.only(left: 10),
                              scrollDirection: Axis.horizontal,
                              itemCount: state.allCategoryList.length + 1,
                              itemBuilder: (context, index) {
                                if (index < state.allCategoryList.length) {
                                  final category = state.allCategoryList[index];
                                  return GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<HomeBloc>(context)
                                          .add(CategoryUpdateTab(index));
                                    },
                                    onLongPress: () {
                                      ViOptionBottomSheet()
                                          .showEditCategoryBottomSheet(
                                        context,
                                        onEdit: () {
                                          ViEditBottomSheet
                                              .onEditCategoryBottomSheet(
                                            context: context,
                                            oldCategory: category,
                                            bloc: BlocProvider.of<HomeBloc>(
                                                context),
                                          );
                                        },
                                        onDelete: () {
                                          print("object");
                                          BlocProvider.of<HomeBloc>(context)
                                              .add(DeleteCategoryEvent(
                                                  categoryModel: category));
                                          Navigator.pop(context);
                                        },
                                      );
                                    },
                                    child: ViContainer(
                                      bgColor: state.taskCategoryIndex == index
                                          ? AppColors.primary
                                          : AppColors.ligthGrey,
                                      margin: const EdgeInsets.only(
                                          right: ViSizes.sm),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      borderRadius: BorderRadius.circular(50),
                                      child: Center(
                                        child: Text(
                                          "${category.name} (${state.getTaskCount(index)})",
                                          style:
                                              state.taskCategoryIndex == index
                                                  ? ViTextTheme
                                                      .darkTextTheme.titleSmall
                                                  : ViTextTheme.ligthTextTheme
                                                      .titleSmall,
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return GestureDetector(
                                    onTap: () => ViAddCategoryBottomSheet
                                        .onAddCategoryBottomSheet(
                                            bloc: BlocProvider.of<HomeBloc>(
                                                context),
                                            controller: controller,
                                            context: context),
                                    child: ViContainer(
                                      bgColor: AppColors.ligthGrey,
                                      margin: const EdgeInsets.only(
                                          right: ViSizes.sm),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      borderRadius: BorderRadius.circular(50),
                                      child: const Center(
                                        child: Icon(
                                          Icons.add,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                        ViRotioButton(
                          onTap: () {
                            context.push(ViRoutes.search_view);
                          },
                          bgColor: AppColors.white,
                          child: const Icon(Iconsax.search_normal),
                        ),
                        SizedBox(width: ViSizes.sm),
                      ],
                    ),
                    Expanded(
                      child: tasksToShow.isEmpty
                          ? const ViEmptyScreen(
                              image: ViImages.empty_screen_image_1,
                              title: "No Tasks Found",
                              subTitle: "Start by adding a new task.",
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
                                  onTap: () => ViOptionBottomSheet()
                                      .showOptionBottomSheet(
                                    context,
                                    onEdit: () {
                                      print(
                                          "Edit option selected"); // Log for debugging
                                      ViEditBottomSheet.onEditBottomSheet(
                                        context: context,
                                        task: task,
                                        bloc:
                                            BlocProvider.of<HomeBloc>(context),
                                        index: index,
                                      );
                                    },
                                    onDelete: () {
                                      print(
                                          "Delete option selected"); // Log for debugging
                                      BlocProvider.of<HomeBloc>(context)
                                          .add(DeleteToDoEvent(task: task));
                                      context.pop();
                                    },
                                    onMarkAsComplete: () {
                                      print(
                                          "Mark as complete option selected"); // Log for debugging
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
