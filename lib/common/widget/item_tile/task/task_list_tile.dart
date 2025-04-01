import 'package:TiDo/utils/Constant/sizes.dart';
import 'package:TiDo/utils/Theme/custom_theme.dart/text_theme.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/task_model/task_model.dart';
import '../../../../utils/Constant/colors.dart';
import '../../../../utils/Helpers/helpers_functions.dart';
import '../../../styles/container_style.dart';

class ViTaskListTile extends StatelessWidget {
  const ViTaskListTile({
    super.key,
    required this.title,
    required this.description,
    this.optionTap,
    this.onTap,
    required this.files,
    required this.dueTime,
    required this.task,
  });

  final String title;
  final String description;
  final String files;
  final Widget? dueTime;
  final Function()? optionTap;
  final Function()? onTap;
  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    final dark = ViHelpersFunctions.isDarkMode(context);
    return ViContainer(
      borderColor: dark ? AppColors.light : Theme.of(context).primaryColor,
      onTap: onTap,
      margin:
          EdgeInsets.symmetric(horizontal: ViSizes.md, vertical: ViSizes.sm),
      width: double.infinity,
      bgColor: task.isChecked == true
          ? Theme.of(context).primaryColor
          : Colors.transparent,
      borderRadius: BorderRadius.circular(ViSizes.borderRadiusLg),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: ViSizes.defaultSpace / 1.5,
            vertical: ViSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title.length > 15 ? title.substring(0, 15) + '...' : title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: ViTextTheme.darkTextTheme.headlineMedium?.copyWith(
                    decoration: task.isChecked == true
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationThickness: 2,
                    decorationColor: AppColors.black,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.light
                        : (task.isChecked == true
                            ? AppColors.light
                            : AppColors.dark),
                  ),
                ),
                IconButton(
                  onPressed: optionTap,
                  icon: Icon(
                    Icons.more_horiz,
                    size: ViSizes.iconLg,
                  ),
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.light
                      : (task.isChecked == true
                          ? AppColors.light
                          : AppColors.dark),
                ),
              ],
            ),
            if (task.description!.isNotEmpty)
              Text(
                description,
                style: ViTextTheme.darkTextTheme.titleMedium?.copyWith(
                  decoration: task.isChecked == true
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  decorationThickness: 2,
                  decorationColor: AppColors.black,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.light
                      : (task.isChecked == true
                          ? AppColors.darkGrey
                          : AppColors.darkerGrey),
                ),
              ),
            if (task.description!.isNotEmpty)
              SizedBox(height: ViSizes.defaultSpace),
            if (task.files!.isNotEmpty || dueTime != null)
              Row(
                children: [
                  if (task.taskTime != null)
                    ViContainer(
                      bgColor: AppColors.white.withValues(alpha: 0.3),
                      borderColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? AppColors.light
                              : (task.isChecked
                                  ? AppColors.light
                                  : AppColors.black),
                      padding: EdgeInsets.symmetric(
                          horizontal: ViSizes.defaultSpace,
                          vertical: ViSizes.defaultSpace / 4),
                      borderRadius:
                          BorderRadius.circular(ViSizes.borderRadiusLg),
                      child: dueTime,
                    ),
                  SizedBox(width: ViSizes.sm),
                  if (task.files!.isNotEmpty)
                    ViContainer(
                      bgColor: AppColors.white.withValues(alpha: 0.3),
                      borderColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? AppColors.light
                              : (task.isChecked
                                  ? AppColors.light
                                  : AppColors.black),
                      padding: EdgeInsets.symmetric(
                          horizontal: ViSizes.defaultSpace,
                          vertical: ViSizes.defaultSpace / 4),
                      borderRadius:
                          BorderRadius.circular(ViSizes.borderRadiusLg),
                      child: Text("$files Files"),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
