import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/home_bloc/home_bloc.dart';
import '../../../../blocs/home_bloc/home_state.dart';
import '../../common/empty_view/empty_view.dart';
import '../../../../common/widget/appbar/appbar.dart';
import '../../../../common/widget/item_tile/selected_files_tile.dart';
import '../../../../core/l10n/l10n.dart';
import '../../../../data/models/task_model/task_model.dart';
import '../../../../utils/Constant/colors.dart';
import '../../../../utils/Constant/image_strings.dart';
import '../../../../utils/Constant/sizes.dart';
import '../../../../utils/Helpers/helpers_functions.dart';
import '../../../../utils/Theme/custom_theme.dart/text_theme.dart';

class DocFolderDetailesView extends StatelessWidget {
  const DocFolderDetailesView({super.key});

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
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            final List<TaskModel> tasks = state.allTasksList;
            final documentFiles =
                tasks.expand((task) => task.files ?? []).where((filePath) {
              final fileExtension = filePath.split('.').last.toLowerCase();
              return ['pdf', 'doc', 'docx'].contains(fileExtension);
            }).toList();

            if (documentFiles.isEmpty) {
              return Center(
                child: ViEmptyScreen(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  size: ViHelpersFunctions.screenHeigth(context) * 0.3,
                  image: ViImages.empty_screen_image_1,
                  title: AppLocalizations.of(context)!.no_files_found,
                  subTitle: AppLocalizations.of(context)!.no_files_subTitle,
                ),
              );
            }

            return ListView.builder(
              itemCount: documentFiles.length,
              itemBuilder: (context, index) {
                final filePath = documentFiles[index];
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

    if (['pdf', 'doc', 'docx'].contains(fileExtension)) {
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
    } else {
      return const Icon(
        Icons.insert_drive_file,
        size: 30,
        color: AppColors.white,
      );
    }
  }
}
