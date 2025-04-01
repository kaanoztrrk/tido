import 'package:flutter/material.dart';

import '../../../../../common/styles/container_style.dart';
import '../../../../../common/widget/Text/title.dart';
import '../../../../../core/l10n/l10n.dart';
import '../../../../../utils/Constant/colors.dart';
import '../../../../../utils/Constant/sizes.dart';
import '../../../../../utils/Theme/custom_theme.dart/text_theme.dart';

class CreateTaskTitleSections extends StatelessWidget {
  const CreateTaskTitleSections({
    super.key,
    required this.dark,
    required this.titleController,
    required this.descriptionController,
  });

  final bool dark;
  final TextEditingController titleController;
  final TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ViPrimaryTitle(
          title: AppLocalizations.of(context)!.title_text,
          textColor: dark ? AppColors.light : AppColors.dark,
        ),
        const SizedBox(height: ViSizes.spaceBtwItems),
        // Title Input
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
        // Description Input
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
      ],
    );
  }
}
