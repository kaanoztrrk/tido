import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/home_bloc/home_bloc.dart';
import '../../blocs/home_bloc/home_event.dart';
import '../../common/styles/container_style.dart';
import '../../common/widget/Text/title.dart';
import '../../common/widget/appbar/appbar.dart';
import '../../common/widget/button/primary_button.dart';
import '../../common/widget/button/ratio_button.dart';
import '../../common/widget/label_widget.dart';
import '../../core/l10n/l10n.dart';
import '../../data/models/task_model/task_model.dart';
import '../../data/services/date_formetter_service.dart';
import '../../utils/Constant/colors.dart';
import '../../utils/Constant/sizes.dart';
import '../../utils/Device/device_utility.dart';
import '../../utils/Helpers/helpers_functions.dart';
import '../../utils/Snackbar/snacbar_service.dart';
import '../../utils/Theme/custom_theme.dart/text_theme.dart';
import '../create_task/widget/date_picker.dart';
import '../create_task/widget/folder_upload.dart';

class TaskEditView extends StatefulWidget {
  final TaskModel task;
  const TaskEditView({super.key, required this.task});

  @override
  State<TaskEditView> createState() => _TaskEditViewState();
}

class _TaskEditViewState extends State<TaskEditView> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime? taskTime;
  List<String> selectedFiles = [];
  List<String> participantImages = [];
  List<String> label = [];

  @override
  void initState() {
    super.initState();
    selectedFiles = widget.task.files ?? [];
    titleController.text = widget.task.title;
    descriptionController.text = widget.task.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: ViAppBar(
        leadingWidget: ViRotioButton(
          onTap: () {
            context.pop();
            context.pop();
          },
          child: const Icon(CupertinoIcons.clear),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(ViSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ViPrimaryTitle(title: AppLocalizations.of(context)!.title_text),
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
                  hintText: widget.task.title,
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
                  hintText: widget.task.description,
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
            ViPrimaryTitle(title: AppLocalizations.of(context)!.description),
            const SizedBox(height: ViSizes.spaceBtwItems),
            Row(
              children: [
                Flexible(
                  child: ViDatePicker(
                    title: widget.task
                            .formattedTaskTime(DateFormatterService(context))
                            .isNotEmpty
                        ? "${widget.task.formattedTaskTime(DateFormatterService(context))}\n"
                        : "${AppLocalizations.of(context)!.date}\n",
                    subtitle: widget.task
                            .formattedDate(DateFormatterService(context))
                            .isNotEmpty
                        ? widget.task
                            .formattedDate(DateFormatterService(context))
                        : AppLocalizations.of(context)!.selected,
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
            const SizedBox(height: ViSizes.spaceBtwItems / 2),
            ViLabeWidget(
              tags: label,
              onTagsUpdated: (labels) {},
            ),
            const Spacer(),
            ViPrimaryButton(
              onTap: () {
                if (titleController.text.isEmpty) {
                  ViSnackbar.showError(
                      context, AppLocalizations.of(context)!.title_empty);
                  return;
                }

                final updatedTask = TaskModel(
                  id: widget.task.id,
                  taskTime: taskTime ?? widget.task.taskTime,
                  title: titleController.text,
                  description: descriptionController.text,
                  files:
                      selectedFiles.isEmpty ? widget.task.files : selectedFiles,
                  labels: label.isNotEmpty ? label : widget.task.labels,
                );

                BlocProvider.of<HomeBloc>(context).add(
                  UpdateToDoEvent(
                    oldTask: widget.task, // Eski görev
                    newTask: updatedTask, // Güncellenmiş görev
                  ),
                );

                // Show success message and navigate back
                ViSnackbar.showSuccess(
                    context, AppLocalizations.of(context)!.task_complated);
                context.pop(context);
                context.pop(context);
                ViDeviceUtils.hideKeyboard(context);
              },
              text: AppLocalizations.of(context)!.update_task,
            )
          ],
        ),
      ),
    );
  }
}
