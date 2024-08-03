import 'package:flutter/material.dart';
import 'package:tido/data/models/task_model/task_model.dart';
import 'package:tido/utils/Constant/colors.dart';
import 'package:tido/utils/Constant/sizes.dart';
import 'package:tido/utils/Helpers/helpers_functions.dart';
import 'package:tido/utils/Theme/custom_theme.dart/text_theme.dart';
import 'package:tido/common/widget/Text/title.dart';

import 'package:tido/views/task_detail/widget/task_info.dart';

void showTaskDetailBottomSheet(BuildContext context, TaskModel task) {
  var dark = ViHelpersFunctions.isDarkMode(context);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16.0,
            right: 16.0,
            top: 16.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.title,
                style: dark
                    ? ViTextTheme.darkTextTheme.headlineLarge
                        ?.copyWith(fontWeight: FontWeight.w600)
                    : ViTextTheme.ligthTextTheme.headlineLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: ViSizes.spaceBtwSections),
              ViPrimaryTitle(title: "DESCRIPTION"),
              SizedBox(height: ViSizes.spaceBtwItems),
              ViPrimaryTitle(
                title:
                    "Reprehenderit excepteur ad irure magna sit adipisicing. Reprehenderit excepteur ad irure magna sit adipisicing.",
                smallText: true,
                secondTextColor: AppColors.secondaryText,
              ),
            ],
          ),
        ),
      );
    },
  );
}
