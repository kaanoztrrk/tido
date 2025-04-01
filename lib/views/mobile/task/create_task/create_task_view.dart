import 'package:TiDo/data/models/category_model/category_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../blocs/home_bloc/home_bloc.dart';
import '../../../../blocs/home_bloc/home_event.dart';
import '../../../../blocs/localization_bloc/localization_bloc.dart';
import '../../../../common/styles/container_style.dart';
import '../../../../common/widget/Text/title.dart';
import '../../../../common/widget/appbar/appbar.dart';
import '../../../../common/widget/button/primary_button.dart';
import '../../../../common/widget/button/ratio_button.dart';
import '../../../../core/l10n/l10n.dart';
import '../../../../utils/Constant/colors.dart';
import '../../../../utils/Constant/sizes.dart';
import '../../../../utils/Device/device_utility.dart';
import '../../../../utils/Helpers/helpers_functions.dart';
import '../../../../utils/Snackbar/snacbar_service.dart';
import '../../../../utils/Theme/custom_theme.dart/text_theme.dart';
import '../../../../utils/constant/enums.dart';
import 'widget/folder_upload.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;

import 'widget/priority_picker.dart';
import 'widget/title_sections.dart';

class CreateTaskView extends StatefulWidget {
  const CreateTaskView({super.key});

  @override
  State<CreateTaskView> createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends State<CreateTaskView> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime? taskTime;
  DateTime? _selectedDateTime;
  List<String> selectedFiles = [];
  List<String> participantImages = [];
  List<CategoryModel> label = [];
  String priority = "low";

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
            //* Title and Description Sections
            CreateTaskTitleSections(
              dark: dark,
              titleController: titleController,
              descriptionController: descriptionController,
            ),
            //* Detailes Sections
            ViPrimaryTitle(title: AppLocalizations.of(context)!.detailes_text),
            const SizedBox(height: ViSizes.spaceBtwItems),
            Row(
              children: [
                Flexible(
                  child: GestureDetector(
                    onTap: () async {
                      final localizationState =
                          context.read<LocalizationBloc>().state;
                      final currentLocale =
                          localizationState.selectedLanguage.locale;

                      await picker.DatePicker.showDateTimePicker(
                        context,
                        showTitleActions: true,
                        onConfirm: (date) {
                          if (date.isBefore(DateTime.now())) {
                            ViSnackbar.showError(
                                context, "Please select a future date.");
                          } else {
                            setState(() {
                              _selectedDateTime = date;
                            });
                          }
                        },
                        currentTime: DateTime.now().add(Duration(minutes: 1)),
                        locale: currentLocale.languageCode == 'en'
                            ? picker.LocaleType.en
                            : picker.LocaleType.tr,
                        theme: picker.DatePickerTheme(
                          backgroundColor:
                              dark ? AppColors.dark : AppColors.light,
                          itemStyle: TextStyle(
                            color: dark ? AppColors.light : AppColors.dark,
                          ),
                          cancelStyle: TextStyle(
                            color: dark ? AppColors.light : AppColors.dark,
                          ),
                          doneStyle: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      );
                    },
                    child: ViContainer(
                      margin: const EdgeInsets.all(ViSizes.sm / 2),
                      padding: const EdgeInsets.all(ViSizes.sm),
                      borderRadius: BorderRadius.circular(30),
                      height: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ViRotioButton(
                            bgColor: Theme.of(context).primaryColor,
                            child: const Icon(
                              Iconsax.calendar_1,
                              color: AppColors.white,
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              _selectedDateTime != null
                                  ? Padding(
                                      padding: const EdgeInsets.all(ViSizes.sm),
                                      child: Text.rich(TextSpan(
                                        text:
                                            "${_selectedDateTime!.hour}:${_selectedDateTime!.minute.toString().padLeft(2, '0')}\n",
                                        style: dark
                                            ? ViTextTheme
                                                .darkTextTheme.headlineLarge
                                                ?.copyWith(
                                                    color: AppColors.white,
                                                    fontWeight: FontWeight.bold)
                                            : ViTextTheme
                                                .ligthTextTheme.headlineLarge
                                                ?.copyWith(
                                                    color:
                                                        AppColors.primaryText,
                                                    fontWeight:
                                                        FontWeight.bold),
                                        children: [
                                          TextSpan(
                                            text:
                                                "${_selectedDateTime!.day}/${_selectedDateTime!.month}/${_selectedDateTime!.year}",
                                            style: dark
                                                ? ViTextTheme
                                                    .darkTextTheme.titleLarge
                                                    ?.copyWith(
                                                        color: AppColors
                                                            .secondaryText)
                                                : ViTextTheme
                                                    .ligthTextTheme.titleLarge
                                                    ?.copyWith(
                                                        color: AppColors
                                                            .secondaryText),
                                          ),
                                        ],
                                      )),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(ViSizes.sm),
                                      child: Text.rich(TextSpan(
                                        text:
                                            "${AppLocalizations.of(context)!.date}\n",
                                        style: dark
                                            ? ViTextTheme
                                                .darkTextTheme.headlineMedium
                                                ?.copyWith(
                                                    color: AppColors.white,
                                                    fontWeight: FontWeight.bold)
                                            : ViTextTheme
                                                .ligthTextTheme.headlineMedium
                                                ?.copyWith(
                                                    color:
                                                        AppColors.primaryText,
                                                    fontWeight:
                                                        FontWeight.bold),
                                        children: [
                                          TextSpan(
                                            text: AppLocalizations.of(context)!
                                                .selected,
                                            style: dark
                                                ? ViTextTheme
                                                    .darkTextTheme.titleLarge
                                                    ?.copyWith(
                                                        color: AppColors
                                                            .secondaryText)
                                                : ViTextTheme
                                                    .ligthTextTheme.titleLarge
                                                    ?.copyWith(
                                                        color: AppColors
                                                            .secondaryText),
                                          ),
                                        ],
                                      )),
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
            ViPriorityPicker(
              initialPriority: priority,
              onPrioritySelected: (newPriority) {
                setState(() {
                  priority = newPriority;
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
                      taskTime: _selectedDateTime, // Add selected datetime
                      participantImages: participantImages,
                      files: selectedFiles,
                      categories: label,
                      priority: priority,
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
