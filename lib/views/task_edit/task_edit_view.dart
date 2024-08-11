import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tido/blocs/home_bloc/home_bloc.dart';
import 'package:tido/blocs/home_bloc/home_event.dart';
import 'package:tido/common/bottom_sheet/files_bottom_sheet.dart';
import 'package:tido/data/models/task_model/task_model.dart';
import 'package:tido/common/widget/label_widget.dart';

import '../../common/styles/container_style.dart';
import '../../common/widget/Text/title.dart';
import '../../common/widget/appbar/appbar.dart';
import '../../common/widget/button/primary_button.dart';
import '../../common/widget/button/ratio_button.dart';
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
    titleController.text = widget.task.title ?? '';
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
            const ViPrimaryTitle(title: "TITLE"),
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
            const ViPrimaryTitle(title: "DETAILES"),
            const SizedBox(height: ViSizes.spaceBtwItems),
            Row(
              children: [
                Flexible(
                  child: ViDatePicker(
                    title: widget.task.formattedTaskTime.isNotEmpty
                        ? "${widget.task.formattedTaskTime}\n"
                        : "No Date\n",
                    subtitle: widget.task.formattedDate.isNotEmpty
                        ? widget.task.formattedDate
                        : "Date Time\n",
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
                  ViSnackbar.showError(context, "Title cannot be empty.");
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
                ViSnackbar.showSuccess(context, "Task updated successfully.");
                context.pop(context);
                context.pop(context);
                ViDeviceUtils.hideKeyboard(context);
              },
              text: "Update Task",
            )
          ],
        ),
      ),
    );
  }
}
