import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../common/widget/button/ratio_button.dart';
import '../../../core/widget/user/profile_image.dart';
import '../../../utils/Constant/colors.dart';
import '../../../utils/Constant/sizes.dart';
import '../../../utils/Helpers/helpers_functions.dart';
import '../../../utils/Theme/custom_theme.dart/text_theme.dart';

class ViTaskInfoWidget extends StatelessWidget {
  const ViTaskInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        created_info(dark),
        dead_time(dark),
      ],
    );
  }

  Row dead_time(bool dark) {
    return Row(
      children: [
        const ViRotioButton(
          child: Icon(Iconsax.calendar),
        ),
        const SizedBox(width: ViSizes.sm),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Due Time",
              style: dark
                  ? ViTextTheme.darkTextTheme.titleLarge
                  : ViTextTheme.ligthTextTheme.titleLarge,
            ),
            Text(
              "16 Oct 2024",
              style: dark
                  ? ViTextTheme.darkTextTheme.titleLarge?.copyWith(
                      color: AppColors.secondaryText,
                      fontWeight: FontWeight.normal)
                  : ViTextTheme.ligthTextTheme.titleLarge?.copyWith(
                      color: AppColors.secondaryText,
                      fontWeight: FontWeight.normal),
            ),
          ],
        )
      ],
    );
  }

  Row created_info(bool dark) {
    return Row(
      children: [
        const ViProfileImage(),
        const SizedBox(width: ViSizes.sm),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Created",
              style: dark
                  ? ViTextTheme.darkTextTheme.titleLarge
                  : ViTextTheme.ligthTextTheme.titleLarge,
            ),
            Text(
              "Kaan Öztürk",
              style: dark
                  ? ViTextTheme.darkTextTheme.titleLarge?.copyWith(
                      color: AppColors.secondaryText,
                      fontWeight: FontWeight.normal)
                  : ViTextTheme.ligthTextTheme.titleLarge?.copyWith(
                      color: AppColors.secondaryText,
                      fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ],
    );
  }
}
