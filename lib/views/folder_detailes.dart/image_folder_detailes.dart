import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/home_bloc/home_bloc.dart';
import '../../blocs/home_bloc/home_state.dart';
import '../common/empty_screen/empty_screen.dart';
import '../../common/widget/appbar/appbar.dart';
import '../../common/widget/task_tile/selected_files_tile.dart';
import '../../core/l10n/l10n.dart';
import '../../data/models/task_model/task_model.dart';
import '../../utils/Constant/colors.dart';
import '../../utils/Constant/image_strings.dart';
import '../../utils/Constant/sizes.dart';
import '../../utils/Helpers/helpers_functions.dart';
import '../../utils/Theme/custom_theme.dart/text_theme.dart';

class ImageFolderDetailesView extends StatelessWidget {
  const ImageFolderDetailesView({super.key});

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    return Scaffold(
      appBar: ViAppBar(
        centerTitle: true,
        showBackArrow: true,
        title: Text(
          AppLocalizations.of(context)!.image,
          style: dark
              ? ViTextTheme.darkTextTheme.headlineMedium
                  ?.copyWith(color: AppColors.white)
              : ViTextTheme.ligthTextTheme.headlineMedium
                  ?.copyWith(color: AppColors.primaryText),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(ViSizes.defaultSpace),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            final List<TaskModel> tasks = state.allTasksList;
            final imageFiles =
                tasks.expand((task) => task.files ?? []).where((filePath) {
              final fileExtension = filePath.split('.').last.toLowerCase();
              return ['jpg', 'jpeg', 'png'].contains(fileExtension);
            }).toList();

            if (imageFiles.isEmpty) {
              return Center(
                child: ViEmptyScreen(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  size: ViHelpersFunctions.screenHeigth(context) * 0.3,
                  image: ViImages.empty_screen_image_1,
                  title: AppLocalizations.of(context)!.no_images_found,
                  subTitle: AppLocalizations.of(context)!.no_images_subTitle,
                ),
              );
            }

            return ListView.builder(
              itemCount: imageFiles.length,
              itemBuilder: (context, index) {
                final filePath = imageFiles[index];
                return SelectedFilesTile(
                  leading: _buildFileItem(filePath),
                  title: filePath.split('/').last,
                );
              },
            );
          },
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
