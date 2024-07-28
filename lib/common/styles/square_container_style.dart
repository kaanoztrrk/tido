import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/Constant/colors.dart';
import '../../utils/Constant/sizes.dart';
import '../../utils/Helpers/helpers_functions.dart';
import '../../utils/Theme/custom_theme.dart/text_theme.dart';
import '../widget/button/ratio_button.dart';
import 'container_style.dart';

class ViSquareContainer extends StatelessWidget {
  const ViSquareContainer(
      {super.key,
      this.widget,
      this.icon,
      this.title,
      this.subTitle,
      this.ontap});

  final Widget? widget;
  final IconData? icon;
  final String? title;
  final String? subTitle;
  final Function()? ontap;
  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: ontap,
      child: ViContainer(
        margin: const EdgeInsets.all(ViSizes.sm / 2),
        padding: const EdgeInsets.all(ViSizes.sm),
        borderRadius: BorderRadius.circular(30),
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ViRotioButton(
              bgColor: AppColors.primary,
              child: Icon(
                icon,
                color: AppColors.white,
              ),
            ),
            const Spacer(),
            widget ??
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(ViSizes.sm),
                      child: Text.rich(TextSpan(
                          text: "$title\n",
                          style: dark
                              ? ViTextTheme.darkTextTheme.headlineLarge
                                  ?.copyWith(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold)
                              : ViTextTheme.ligthTextTheme.headlineLarge
                                  ?.copyWith(
                                      color: AppColors.primaryText,
                                      fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                              text: subTitle,
                              style: dark
                                  ? ViTextTheme.darkTextTheme.titleLarge
                                      ?.copyWith(color: AppColors.secondaryText)
                                  : ViTextTheme.ligthTextTheme.titleLarge
                                      ?.copyWith(
                                          color: AppColors.secondaryText),
                            )
                          ])),
                    )
                  ],
                )
          ],
        ),
      ),
    );
  }
}
