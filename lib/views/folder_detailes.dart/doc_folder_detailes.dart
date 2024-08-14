import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tido/blocs/home_bloc/home_bloc.dart';
import 'package:tido/common/widget/task_tile/selected_files_tile.dart';
import 'package:tido/core/l10n/l10n.dart';
import 'package:tido/data/models/task_model/task_model.dart';
import 'package:tido/utils/Constant/colors.dart';
import 'package:tido/utils/Constant/sizes.dart';
import 'package:tido/utils/Theme/custom_theme.dart/text_theme.dart';
import 'package:tido/utils/Helpers/helpers_functions.dart';

import '../../blocs/home_bloc/home_state.dart';
import '../../common/widget/appbar/appbar.dart';

class DocFolderDetailesView extends StatelessWidget {
  const DocFolderDetailesView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    return Scaffold(
      appBar: ViAppBar(
        centerTitle: true,
        showBackArrow: true,
        title: Text(
          AppLocalizations.of(context)!.doc,
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
                      final docFiles = task.files?.where((filePath) {
                            final fileExtension =
                                filePath.split('.').last.toLowerCase();
                            return ['pdf', 'doc', 'docx']
                                .contains(fileExtension);
                          }).toList() ??
                          [];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (docFiles.isNotEmpty) ...[
                            ...docFiles.map((filePath) {
                              return SelectedFilesTile(
                                leading: _buildFileItem(filePath),
                                title: filePath.split('/').last,
                              );
                            }),
                          ],
                        ],
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
