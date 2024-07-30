import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tido/blocs/home_bloc/home_bloc.dart';
import 'package:tido/common/widget/task_tile/selected_files_tile.dart';
import 'package:tido/data/models/task_model/task_model.dart';
import 'package:tido/utils/Constant/colors.dart';
import 'package:tido/utils/Constant/sizes.dart';
import 'package:tido/utils/Theme/custom_theme.dart/text_theme.dart';
import 'package:tido/utils/Helpers/helpers_functions.dart';

import '../../blocs/home_bloc/home_state.dart';
import '../../common/widget/appbar/appbar.dart';

class ImageFolderDetailesView extends StatelessWidget {
  const ImageFolderDetailesView({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    return Scaffold(
      appBar: ViAppBar(
        centerTitle: true,
        showBackArrow: true,
        title: Text(
          title,
          style: dark
              ? ViTextTheme.darkTextTheme.headlineMedium
                  ?.copyWith(color: AppColors.white)
              : ViTextTheme.ligthTextTheme.headlineMedium
                  ?.copyWith(color: AppColors.primaryText),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(ViSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  final List<TaskModel> tasks = state.allTasksList;

                  return ListView.builder(
                    reverse: false,
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      final imageFiles = task.files?.where((filePath) {
                            final fileExtension =
                                filePath.split('.').last.toLowerCase();
                            return ['jpg', 'jpeg', 'png']
                                .contains(fileExtension);
                          }).toList() ??
                          [];

                      if (imageFiles.isEmpty) {
                        return SelectedFilesTile(
                          leading: _buildFileItem(""),
                          title: "No Image File",
                        );
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: imageFiles.map((filePath) {
                          return SelectedFilesTile(
                            leading: _buildFileItem(filePath),
                            title: filePath.split('/').last,
                          );
                        }).toList(),
                      );
                    },
                  );
                },
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
