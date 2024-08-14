import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tido/blocs/home_bloc/home_bloc.dart';
import 'package:tido/common/widget/appbar/appbar.dart';
import 'package:tido/common/widget/button/ratio_button.dart';
import 'package:tido/common/widget/label_widget.dart';
import 'package:tido/utils/Snackbar/snacbar_service.dart';
import 'package:tido/views/create_task/widget/date_picker.dart';
import 'package:tido/views/create_task/widget/folder_upload.dart';

import '../../blocs/home_bloc/home_event.dart';
import '../../common/styles/container_style.dart';
import '../../common/widget/Text/title.dart';
import '../../common/widget/button/primary_button.dart';
import '../../utils/Constant/colors.dart';
import '../../utils/Constant/sizes.dart';
import '../../utils/Device/device_utility.dart';
import '../../utils/Helpers/helpers_functions.dart';
import '../../utils/Loader/vi_loader.dart';
import '../../utils/Theme/custom_theme.dart/text_theme.dart';

class CreateTaskView extends StatefulWidget {
  const CreateTaskView({super.key});

  @override
  State<CreateTaskView> createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends State<CreateTaskView> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime? taskTime;
  List<String> selectedFiles = [];
  List<String> participantImages = [];
  List<String> label = [];

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: ViAppBar(
        leadingWidget: ViRotioButton(
          onTap: () => context.pop(),
          child: const Icon(CupertinoIcons.clear),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(ViSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ViPrimaryTitle(
              title: "TITLE",
              textColor: dark ? AppColors.dark : AppColors.light,
            ),
            const SizedBox(height: ViSizes.spaceBtwItems),
            ViContainer(
              padding: const EdgeInsets.only(left: 5, top: 10),
              height: 65,
              decoration: BoxDecoration(
                color: dark ? AppColors.black : AppColors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  filled: false,
                  hintText: "Title",
                  hintStyle: dark
                      ? ViTextTheme.darkTextTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.normal)
                      : ViTextTheme.ligthTextTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.normal),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: ViSizes.spaceBtwItems),
            ViContainer(
              padding: const EdgeInsets.only(left: 5, top: 10),
              height: 65,
              decoration: BoxDecoration(
                color: dark ? AppColors.black : AppColors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  filled: false,
                  hintText: "Description",
                  hintStyle: dark
                      ? ViTextTheme.darkTextTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.normal)
                      : ViTextTheme.ligthTextTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.normal),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: ViSizes.spaceBtwSections),
            const ViPrimaryTitle(title: "DETAILES"),
            const SizedBox(height: ViSizes.spaceBtwItems),
            Row(
              children: [
                Flexible(
                  child: ViDatePicker(
                    onDateTimeChanged: (dateTime) {
                      setState(() {
                        taskTime = dateTime;
                      });
                    },
                  ),
                ),
                Flexible(
                  child: ViFolderUpload(
                    selectedFiles: selectedFiles,
                    onFilesSelected: (files) {
                      setState(() {
                        selectedFiles = files;
                      });
                    },
                  ),
                ),
              ],
            ),
            ViLabeWidget(
              tags: label,
              onTagsUpdated: (labels) {
                setState(() {
                  label = labels;
                });
              },
            ),
            const Spacer(),
            ViPrimaryButton(
              onTap: () {
                if (titleController.text.isEmpty) {
                } else {
                  BlocProvider.of<HomeBloc>(context).add(
                    CreateToDoEvent(
                      title: titleController.text,
                      description: descriptionController.text,
                      taskTime: taskTime,
                      participantImages: participantImages,
                      files: selectedFiles,
                      labels: label,
                    ),
                  );

                  ViSnackbar.showSuccess(context, "Task created successfully.");
                  context.pop();
                  ViDeviceUtils.hideKeyboard(context);
                }
              },
              text: "Create Task",
            ),
          ],
        ),
      ),
    );
  }
}
