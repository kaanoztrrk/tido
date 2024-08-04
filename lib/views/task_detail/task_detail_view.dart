import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tido/data/models/task_model/task_model.dart';
import 'package:tido/utils/Constant/colors.dart';
import 'package:tido/utils/Constant/sizes.dart';
import 'package:tido/utils/Device/device_utility.dart';
import 'package:tido/views/task_detail/widget/task_info.dart';

import '../../blocs/home_bloc/home_bloc.dart';
import '../../blocs/home_bloc/home_state.dart';
import '../../common/widget/Text/title.dart';
import '../../common/widget/button/ratio_button.dart';
import '../../common/widget/task_tile/selected_files_tile.dart';

class TaskDetailView extends StatelessWidget {
  final TaskModel task;

  const TaskDetailView({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(ViSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: ViDeviceUtils.getScreenHeigth(context) * 0.4,
              padding: const EdgeInsets.all(ViSizes.defaultSpace / 2),
              margin: const EdgeInsets.only(bottom: 30, top: 20),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradientButton,
                borderRadius: BorderRadius.circular(ViSizes.borderRadiusLg * 2),
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
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(ViSizes.defaultSpace) +
                        const EdgeInsets.only(bottom: ViSizes.defaultSpace),
                    child: ViPrimaryTitle(
                      title: task.title,
                      bigText: true,
                      secondTextColor: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  const ViPrimaryTitle(title: "DESCRIPTION"),
                  const SizedBox(height: ViSizes.spaceBtwItems),
                  ViPrimaryTitle(
                      title: task.description.toString(),
                      secondTextColor: AppColors.secondaryText),
                  const SizedBox(height: ViSizes.spaceBtwSections),
                  ViTaskInfoWidget(
                    task: task,
                  ),
                  const SizedBox(height: ViSizes.spaceBtwSections),
                  const ViPrimaryTitle(title: "FILES"),
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        reverse: false,
                        itemCount: state.allTasksList.length,
                        itemBuilder: (context, index) {
                          final task = state.allTasksList[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...task.files?.map((filePath) {
                                    return SelectedFilesTile(
                                      leading: _buildFileItem(filePath),
                                      title: filePath.split('/').last,
                                    );
                                  }) ??
                                  [
                                    SelectedFilesTile(
                                      leading: _buildFileItem(""),
                                      title: "No File",
                                    ),
                                  ],
                            ],
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
