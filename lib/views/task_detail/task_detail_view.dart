import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tido/blocs/theme_bloc/theme_bloc.dart';
import 'package:tido/common/styles/container_style.dart';
import 'package:tido/common/widget/chip/label_chip.dart';
import 'package:tido/core/locator/locator.dart';
import 'package:tido/core/routes/routes.dart';
import 'package:tido/data/models/task_model/task_model.dart';
import 'package:tido/utils/Constant/colors.dart';
import 'package:tido/utils/Constant/sizes.dart';
import 'package:tido/utils/Device/device_utility.dart';
import 'package:tido/views/task_detail/widget/task_info.dart';

import '../../blocs/home_bloc/home_bloc.dart';
import '../../blocs/home_bloc/home_state.dart';
import '../../blocs/theme_bloc/theme_state.dart';
import '../../common/empty_screen/empty_screen.dart';
import '../../common/widget/Text/title.dart';
import '../../common/widget/button/ratio_button.dart';
import '../../common/widget/task_tile/selected_files_tile.dart';
import '../../utils/Constant/image_strings.dart';

class TaskDetailView extends StatelessWidget {
  final TaskModel task;

  const TaskDetailView({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ThemeBloc>(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(ViSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ViContainer(
                    height: ViDeviceUtils.getScreenHeigth(context) * 0.4,
                    padding: const EdgeInsets.all(ViSizes.defaultSpace / 2),
                    margin: const EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius:
                          BorderRadius.circular(ViSizes.borderRadiusLg * 2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ViRotioButton(
                              onTap: () => context.pop(),
                              child: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: AppColors.white,
                              ),
                            ),
                            ViRotioButton(
                              onTap: () => context.push(ViRoutes.task_edit_view,
                                  extra: task),
                              child: const Icon(
                                Icons.edit,
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(ViSizes.defaultSpace),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ViPrimaryTitle(
                                title: task.title,
                                bigText: true,
                                secondTextColor: AppColors.white,
                              ),
                              SizedBox(
                                height: 50,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.only(left: 0),
                                  itemCount: task.labels!.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: ViLabelChip(
                                        tag: task.labels![index],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        if (task.labels!.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const ViPrimaryTitle(title: "DESCRIPTION"),
                              const SizedBox(height: ViSizes.spaceBtwItems),
                              ViPrimaryTitle(
                                  title: task.description.toString(),
                                  secondTextColor: AppColors.secondaryText),
                              const SizedBox(height: ViSizes.spaceBtwSections),
                            ],
                          ),
                        ViTaskInfoWidget(
                          task: task,
                        ),
                        const SizedBox(height: ViSizes.spaceBtwSections),
                        if (task.files!.isEmpty)
                          const ViPrimaryTitle(title: "FILES"),
                        BlocBuilder<HomeBloc, HomeState>(
                          builder: (context, state) {
                            final files = task.files ?? [];

                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: files.isEmpty ? 1 : files.length,
                              itemBuilder: (context, index) {
                                if (files.isEmpty) {
                                  return Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(
                                          ViSizes.defaultSpace),
                                      child: ViEmptyScreen(
                                        size: ViDeviceUtils.getScreenHeigth(
                                                context) *
                                            0.15,
                                        color: AppColors.darkGrey,
                                        image: ViImages.empty_screen_no_image,
                                        title: "No images found",
                                        subTitle:
                                            "Add images to your task to display them.",
                                      ),
                                    ),
                                  );
                                }

                                final filePath = files[index];
                                return SelectedFilesTile(
                                  leading: _buildFileItem(filePath),
                                  title: filePath.split('/').last,
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFileItem(String filePath) {
    if (filePath.isEmpty) {
      return const Icon(
        Icons.insert_drive_file,
        size: 30,
        color: AppColors.white,
      );
    }

    final fileName = filePath.split('/').last;
    final fileExtension = fileName.split('.').last.toLowerCase();

    if (['jpg', 'jpeg', 'png'].contains(fileExtension)) {
      return Image.file(
        File(filePath),
        fit: BoxFit.cover,
      );
    } else {
      IconData iconData;
      switch (fileExtension) {
        case 'pdf':
          iconData = Icons.picture_as_pdf;
          break;
        case 'doc':
        case 'docx':
          iconData = Icons.description;
          break;
        default:
          iconData = Icons.insert_drive_file;
      }
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            size: 30,
            color: AppColors.white,
          ),
        ],
      );
    }
  }
}
