import 'package:flutter/material.dart';
import 'package:tido/blocs/home_bloc/home_bloc.dart';
import 'package:tido/common/widget/button/primary_button.dart';
import 'package:tido/data/models/task_model/task_model.dart';

import '../../blocs/home_bloc/home_event.dart';
import '../../utils/Constant/colors.dart';
import '../../utils/Constant/sizes.dart';
import '../../utils/Device/device_utility.dart';
import '../../utils/Helpers/helpers_functions.dart';
import '../../utils/Theme/custom_theme.dart/text_theme.dart';
import '../styles/container_style.dart';

class ViEditBottomSheet {
  static void onEditBottomSheet({
    required BuildContext context,
    required TaskModel task,
    required HomeBloc bloc,
    required int index,
  }) {
    final TextEditingController controller =
        TextEditingController(text: task.title);
    var dark = ViHelpersFunctions.isDarkMode(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 16.0,
              right: 16.0,
              top: 16.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ViContainer(
                  padding: const EdgeInsets.only(left: 5, top: 10),
                  height: 65,
                  decoration: BoxDecoration(
                      color: dark ? AppColors.black : AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all()),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      filled: false,
                      hintText: "Description",
                      hintStyle: dark
                          ? ViTextTheme.darkTextTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.normal)
                          : ViTextTheme.ligthTextTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.normal),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: ViSizes.lg),
                ViPrimaryButton(
                  text: "Save",
                  height: ViDeviceUtils.getScreenHeigth(context) * 0.08,
                  onTap: () {
                    final updatedTask = TaskModel(
                        title: controller.text,
                        isChecked: task.isChecked,
                        taskTime: bloc.state.allTasksList[index].taskTime);
                    bloc.add(
                      UpdateToDoEvent(
                        oldTask: task,
                        newTask: updatedTask,
                      ),
                    );
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: ViSizes.sm),
              ],
            ),
          ),
        );
      },
    );
  }

  static void onEditCategoryBottomSheet({
    required BuildContext context,
    required String categoryName,
    required HomeBloc bloc,
    required int index,
  }) {
    final TextEditingController controller =
        TextEditingController(text: categoryName);
    var dark = ViHelpersFunctions.isDarkMode(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 16.0,
              right: 16.0,
              top: 16.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ViContainer(
                  padding: const EdgeInsets.only(left: 5, top: 10),
                  height: 65,
                  decoration: BoxDecoration(
                      color: dark ? AppColors.black : AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all()),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      filled: false,
                      hintText: "Category Name",
                      hintStyle: dark
                          ? ViTextTheme.darkTextTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.normal)
                          : ViTextTheme.ligthTextTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.normal),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: ViSizes.lg),
                ViPrimaryButton(
                  text: "Save",
                  height: ViDeviceUtils.getScreenHeigth(context) * 0.08,
                  onTap: () {
                    final updatedCategoryName = controller.text;
                    if (updatedCategoryName.isNotEmpty) {
                      bloc.add(
                        UpdateCategoryEvent(
                          oldCategoryName: categoryName,
                          newCategoryName: updatedCategoryName,
                        ) as HomeEvent,
                      );
                      Navigator.pop(context);
                    } else {
                      // Optionally show an error if the new name is empty
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Category name cannot be empty."),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: ViSizes.sm),
              ],
            ),
          ),
        );
      },
    );
  }
}
