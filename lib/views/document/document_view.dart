import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tido/blocs/home_bloc/home_bloc.dart';
import 'package:tido/common/empty_screen/empty_screen.dart';
import 'package:tido/common/widget/appbar/home_appbar.dart';
import 'package:tido/common/widget/task_tile/selected_files_tile.dart';
import 'package:tido/data/models/task_model/task_model.dart';
import 'package:tido/utils/Constant/colors.dart';
import 'package:tido/utils/Constant/image_strings.dart';
import 'package:tido/utils/Constant/sizes.dart';
import 'package:tido/utils/Device/device_utility.dart';
import '../../blocs/auth_blocs/sign_in_bloc/sign_in_bloc.dart';
import '../../blocs/home_bloc/home_state.dart';
import '../../common/styles/square_container_style.dart';
import '../../common/widget/Text/title.dart';
import '../../core/locator/locator.dart';
import '../../core/routes/routes.dart';

class DocumentView extends StatelessWidget {
  const DocumentView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider.value(value: getIt<HomeBloc>()),
          BlocProvider.value(value: getIt<SignInBloc>())
        ],
        child: SafeArea(
          child: Scaffold(
            appBar: const ViHomeAppBar(
              height: ViSizes.appBarHeigth * 1.5,
            ),
            body: Padding(
              padding: const EdgeInsets.all(ViSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: ViSquareContainer(
                          icon: Iconsax.document_1,
                          title: "Doc",
                          subTitle: "Folder",
                          ontap: () => context.push(
                            ViRoutes.doc_folder_detailes,
                            extra: "Doc",
                          ),
                        ),
                      ),
                      Flexible(
                        child: ViSquareContainer(
                          icon: Iconsax.image,
                          title: "Image",
                          subTitle: "Folder",
                          ontap: () => context.push(
                              ViRoutes.image_folder_detailes,
                              extra: "Image"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: ViSizes.spaceBtwSections),
                  const ViPrimaryTitle(title: "RECEND FILES"),
                  Expanded(child: BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      final List<TaskModel> tasks = state.allTasksList;
                      if (tasks.isEmpty) {
                        return Center(
                          child: ViEmptyScreen(
                              size:
                                  ViDeviceUtils.getScreenHeigth(context) * 0.1,
                              color: AppColors.darkGrey,
                              image: ViImages.empty_screen_no_image,
                              title: "No images found",
                              subTitle:
                                  "Add images to your task to display them."),
                        );
                      } else {
                        return ListView.builder(
                          reverse: false,
                          itemCount: tasks.length,
                          itemBuilder: (context, index) {
                            final task = tasks[index];
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
                      }
                    },
                  )),
                ],
              ),
            ),
          ),
        ));
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
