// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:TiDo/common/widget/chip/label_chip.dart';
import 'package:TiDo/common/widget/item_tile/premium/premium_item_tile.dart';
import 'package:TiDo/utils/bottom_sheet/widget/bottom_sheet_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../blocs/home_bloc/home_bloc.dart';
import '../../blocs/home_bloc/home_event.dart';
import '../../blocs/home_bloc/home_state.dart';
import '../../blocs/localization_bloc/localization_bloc.dart';
import '../../blocs/localization_bloc/localization_state.dart';
import '../../core/l10n/l10n.dart';
import '../../data/models/category_model/category_model.dart';
import '../../data/models/language_model/language_model.dart';
import '../../data/models/task_model/task_model.dart';
import '../Constant/colors.dart';
import '../Constant/sizes.dart';
import '../Device/device_utility.dart';
import '../Helpers/helpers_functions.dart';
import '../Snackbar/snacbar_service.dart';
import '../Theme/custom_theme.dart/text_theme.dart';
import '../../common/styles/container_style.dart';
import '../../common/widget/Text/title.dart';
import '../../common/widget/button/primary_button.dart';
import '../../common/widget/item_tile/selected_files_tile.dart';

class ViBottomSheet {
  //* add category bottom shet
  static void onAddCategoryBottomSheet({
    required BuildContext context,
    required HomeBloc bloc,
    required TextEditingController controller,
  }) {
    var dark = ViHelpersFunctions.isDarkMode(context);

    showModalBottomSheet(
      showDragHandle: true,
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
                    border: Border.all(),
                  ),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      filled: false,
                      hintText: AppLocalizations.of(context)!.categories,
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
                  text: AppLocalizations.of(context)!.done,
                  height: ViDeviceUtils.getScreenHeigth(context) * 0.08,
                  onTap: () {
                    final categoryName = controller.text.trim();
                    if (categoryName.isNotEmpty) {
                      bloc.add(AddCategoryEvent(categoryName));
                    }
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

  //* change language bottomsheet

  static void showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(ViSizes.defaultSpace),
            child: Column(
              children: [
                ViPrimaryTitle(
                    title: AppLocalizations.of(context)!.chooseLanguage),
                const SizedBox(height: ViSizes.spaceBtwItems),
                BlocBuilder<LocalizationBloc, LocalizationState>(
                  buildWhen: (previous, current) =>
                      previous.selectedLanguage != current.selectedLanguage,
                  builder: (context, state) {
                    return ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final bool isLanguageChosen =
                            LanguageModel.values[index] ==
                                state.selectedLanguage;
                        return ListTile(
                          onTap: () {
                            context.read<LocalizationBloc>().add(
                                ChangeAppLocalization(
                                    selectedLanguage:
                                        LanguageModel.values[index]));

                            Future.delayed(const Duration(microseconds: 300))
                                .then((value) => context.pop());
                          },
                          leading: LanguageModel.values[index].image.image(
                            width: ViSizes.lg * 2,
                            height: ViSizes.lg * 2,
                          ),
                          title: Text(LanguageModel.values[index].text),
                          trailing: isLanguageChosen
                              ? Icon(
                                  Icons.check_circle_rounded,
                                  color: Theme.of(context).primaryColor,
                                )
                              : null,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: isLanguageChosen
                                  ? BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 1.5)
                                  : BorderSide.none),
                          tileColor: isLanguageChosen
                              ? Theme.of(context)
                                  .primaryColor
                                  .withValues(alpha: 0.5)
                              : null,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: ViSizes.defaultSpace),
                          child: Divider(),
                        );
                      },
                      itemCount: LanguageModel.values.length,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //* are you sure

  static void onAreYouSureBottomSheet({
    required BuildContext context,
    required IconData icon,
    Color? iconColor,
    required VoidCallback onTap,
    required VoidCallback cancelOnTap,
    required String title,
    required String subTitle,
  }) {
    showModalBottomSheet(
      showDragHandle: true,
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
                Icon(
                  icon,
                  size: ViSizes.iconLg * 2,
                  color: iconColor ?? Theme.of(context).primaryColor,
                ),
                const SizedBox(height: ViSizes.spaceBtwItems),
                ViPrimaryTitle(title: title),
                const SizedBox(height: ViSizes.spaceBtwItems),
                ViPrimaryTitle(
                  title: subTitle,
                  textColor: AppColors.secondaryText,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: ViSizes.spaceBtwItems),
                ViPrimaryButton(
                  text: AppLocalizations.of(context)!.done,
                  onTap: onTap,
                ),
                MaterialButton(
                  onPressed: cancelOnTap,
                  child: Text(AppLocalizations.of(context)!.cancel),
                ),
                const SizedBox(height: ViSizes.spaceBtwItems),
              ],
            ),
          ),
        );
      },
    );
  }

  //* edit task
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
      showDragHandle: true,
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
                    border: Border.all(),
                  ),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      filled: false,
                      hintText: AppLocalizations.of(context)!.description,
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
                  text: AppLocalizations.of(context)!.done,
                  height: ViDeviceUtils.getScreenHeigth(context) * 0.08,
                  onTap: () {
                    final updatedTask = TaskModel(
                      id: task.id, // Eski görevden id'yi alıyoruz
                      title: controller.text,
                      isChecked: task.isChecked,
                      taskTime: bloc.state.allTasksList[index].taskTime,
                      participantImages: task.participantImages,
                      files: task.files,
                      description: task.description,
                      categories: task.categories,
                    );
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

  //* edit category

  static void onEditCategoryBottomSheet({
    required BuildContext context,
    required CategoryModel oldCategory,
    required HomeBloc bloc,
  }) {
    final TextEditingController controller =
        TextEditingController(text: oldCategory.name);
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
                    border: Border.all(),
                  ),
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
                      final newCategory = oldCategory.copyWith(
                        name: updatedCategoryName,
                      );

                      bloc.add(UpdateCategoryEvent(
                          oldCategory: oldCategory, newCategory: newCategory));

                      ViSnackbar.showSuccess(
                          context, "Category updated successfully");
                      Navigator.pop(context);
                    } else {
                      ViSnackbar.showWarning(
                          context, "Category name cannot be empty.");
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

  //* files bottom sheet

  static void showFilesBottomSheet(
    BuildContext context,
    List<String>? initialFiles,
    Function(List<String>) onFilesUpdated, // Liste güncellenmesi callback
  ) {
    List<String> selectedFiles =
        initialFiles != null ? List.from(initialFiles) : [];
    Set<String> selectedItems = {};

    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      builder: (BuildContext context) {
        final isDarkMode = ViHelpersFunctions.isDarkMode(context);
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.all(ViSizes.sm),
              height: 400,
              child: Column(
                children: [
                  Text(
                    "Selected Files",
                    style: isDarkMode
                        ? ViTextTheme.darkTextTheme.headlineSmall?.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          )
                        : ViTextTheme.ligthTextTheme.headlineSmall?.copyWith(
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.bold,
                          ),
                  ),
                  Expanded(
                    child: selectedFiles.isNotEmpty
                        ? ListView.builder(
                            itemCount: selectedFiles.length,
                            itemBuilder: (context, index) {
                              return SelectedFilesTile(
                                enableLongPress: true,
                                leading: BottomSheetWidget.buildFileItem(
                                    selectedFiles[index]),
                                title: selectedFiles[index].split('/').last,
                                isSelected: selectedItems
                                    .contains(selectedFiles[index]),
                                onSelected: (isSelected) {
                                  setState(() {
                                    if (isSelected) {
                                      selectedItems.add(selectedFiles[index]);
                                    } else {
                                      selectedItems
                                          .remove(selectedFiles[index]);
                                    }
                                  });
                                },
                              );
                            },
                          )
                        : Center(
                            child: Text(AppLocalizations.of(context)!
                                .no_file_selected)),
                  ),
                  if (selectedItems.isNotEmpty)
                    ViPrimaryButton(
                      text: "Delete",
                      onTap: () {
                        setState(() {
                          selectedFiles.removeWhere(
                              (file) => selectedItems.contains(file));
                          selectedItems.clear();
                        });
                        onFilesUpdated(selectedFiles);
                      },
                    )
                ],
              ),
            );
          },
        );
      },
    );
  }

  //* task options

  static void showOptionBottomSheet(
    BuildContext context, {
    required VoidCallback onEdit,
    required VoidCallback onDelete,
    VoidCallback? onMarkAsComplete,
  }) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            children: [
              BottomSheetWidget.buildEditItem(context, onEdit, dark,
                  Iconsax.edit_2, AppLocalizations.of(context)!.task_edit),
              BottomSheetWidget.buildEditItem(context, onDelete, dark,
                  Iconsax.trash, AppLocalizations.of(context)!.task_delete),
              if (onMarkAsComplete != null)
                BottomSheetWidget.buildEditItem(
                    context,
                    onMarkAsComplete,
                    dark,
                    Iconsax.tick_circle,
                    AppLocalizations.of(context)!.task_complated_text),
            ],
          ),
        );
      },
    );
  }

  static void showEditCategoryBottomSheet(
    BuildContext context, {
    required VoidCallback onEdit,
    required VoidCallback onDelete,
  }) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            children: [
              BottomSheetWidget.buildEditItem(context, onEdit, dark,
                  Iconsax.edit_2, AppLocalizations.of(context)!.edit_category),
              BottomSheetWidget.buildEditItem(context, onDelete, dark,
                  Iconsax.trash, AppLocalizations.of(context)!.delete_category),
            ],
          ),
        );
      },
    );
  }

  static void showPremiumBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Adjust padding as necessary
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Go Premium",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),

                // PageView with automatic scroll
                Container(
                  height: MediaQuery.of(context).size.height *
                      0.4, // Dynamically adjust height based on screen size
                  child: AutoSwipePageView(), // Custom widget for auto-swiping
                ),

                ViPrimaryButton(
                  text: "Get Premium for 5.99 USD",
                  onTap: () {
                    // Implement the premium purchase functionality
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(height: ViSizes.spaceBtwItems),
                // Responsively adjust the text size for small and large screens
                Text(
                  "Upon purchase confirmation, 39.99 USD will be charged to your account. This payment grants access to TıDo's premium features.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
