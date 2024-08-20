import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../blocs/auth_blocs/sign_in_bloc/sign_in_bloc.dart';
import '../../blocs/home_bloc/home_bloc.dart';
import '../../blocs/home_bloc/home_state.dart';
import '../../common/empty_screen/empty_screen.dart';
import '../../common/styles/square_container_style.dart';
import '../../common/widget/Text/title.dart';
import '../../common/widget/appbar/home_appbar.dart';
import '../../common/widget/task_tile/selected_files_tile.dart';
import '../../core/l10n/l10n.dart';
import '../../core/locator/locator.dart';
import '../../core/routes/routes.dart';
import '../../data/models/task_model/task_model.dart';
import '../../utils/Constant/colors.dart';
import '../../utils/Constant/image_strings.dart';
import '../../utils/Constant/sizes.dart';
import '../../utils/Helpers/helpers_functions.dart';

class DocumentView extends StatelessWidget {
  const DocumentView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<HomeBloc>()),
        BlocProvider.value(value: getIt<SignInBloc>()),
      ],
      child: SafeArea(
        child: Scaffold(
          appBar: const ViHomeAppBar(
            height: ViSizes.appBarHeigth * 1.5,
          ),
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(ViSizes.defaultSpace),
                child: Row(
                  children: [
                    Flexible(
                      child: ViSquareContainer(
                        icon: Iconsax.document_1,
                        title: AppLocalizations.of(context)!.doc,
                        subTitle: AppLocalizations.of(context)!.files,
                        ontap: () => context.push(ViRoutes.doc_folder_detailes),
                      ),
                    ),
                    Flexible(
                      child: ViSquareContainer(
                        icon: Iconsax.image,
                        title: AppLocalizations.of(context)!.image,
                        subTitle: AppLocalizations.of(context)!.files,
                        ontap: () =>
                            context.push(ViRoutes.image_folder_detailes),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: ViSizes.spaceBtwSections),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: ViSizes.defaultSpace),
                child: ViPrimaryTitle(
                    title: AppLocalizations.of(context)!.recend_files),
              ),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  final List<TaskModel> tasks = state.allTasksList;
                  final List allFiles =
                      tasks.expand((task) => task.files ?? []).toList();

                  if (allFiles.isEmpty) {
                    return Center(
                      child: ViEmptyScreen(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        size: ViHelpersFunctions.screenHeigth(context) * 0.3,
                        image: ViImages.empty_screen_image_1,
                        title: AppLocalizations.of(context)!.no_files_found,
                        subTitle:
                            AppLocalizations.of(context)!.no_files_subTitle,
                      ),
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: allFiles.map((filePath) {
                      return SelectedFilesTile(
                        leading: _buildFileItem(filePath),
                        title: filePath.split('/').last,
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
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
