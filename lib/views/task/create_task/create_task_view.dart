import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../blocs/home_bloc/home_bloc.dart';
import '../../../blocs/home_bloc/home_event.dart';
import '../../../common/styles/container_style.dart';
import '../../../common/widget/Text/title.dart';
import '../../../common/widget/appbar/appbar.dart';
import '../../../common/widget/button/primary_button.dart';
import '../../../common/widget/button/ratio_button.dart';
import '../../../common/widget/label_widget.dart';
import '../../../core/l10n/l10n.dart';
import '../../../utils/Constant/colors.dart';
import '../../../utils/Constant/sizes.dart';
import '../../../utils/Device/device_utility.dart';
import '../../../utils/Helpers/helpers_functions.dart';
import '../../../utils/Snackbar/snacbar_service.dart';
import '../../../utils/Theme/custom_theme.dart/text_theme.dart';
import 'widget/date_picker.dart';
import 'widget/folder_upload.dart';

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
  List<String> category = [];

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
              title: AppLocalizations.of(context)!.title_text,
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
                  hintText: AppLocalizations.of(context)!.title_text,
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
                  hintText: AppLocalizations.of(context)!.description,
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
            ViPrimaryTitle(title: AppLocalizations.of(context)!.detailes_text),
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
              tags: category,
              onTagsUpdated: (categories) {
                setState(() {
                  category = categories;
                });
              },
            ),
            const Spacer(),
            ViPrimaryButton(
              onTap: () async {
                if (titleController.text.isEmpty) {
                  ViSnackbar.showError(
                      context, AppLocalizations.of(context)!.title_required);
                } else {
                  BlocProvider.of<HomeBloc>(context).add(
                    CreateToDoEvent(
                      title: titleController.text,
                      description: descriptionController.text,
                      taskTime: taskTime,
                      participantImages: participantImages,
                      files: selectedFiles,
                      labels: category,
                    ),
                  );

                  ViSnackbar.showSuccess(
                      context, AppLocalizations.of(context)!.task_complated);
                  context.pop();
                  ViDeviceUtils.hideKeyboard(context);
                }
              },
              text: AppLocalizations.of(context)!.create_task_text,
            ),
          ],
        ),
      ),
    );
  }
}
