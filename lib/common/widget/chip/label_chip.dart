import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../utils/Constant/colors.dart';
import '../../../utils/Constant/sizes.dart';
import '../../../utils/Helpers/helpers_functions.dart';
import '../../../utils/Theme/custom_theme.dart/text_theme.dart';
import '../../styles/container_style.dart';
import '../button/ratio_button.dart';

class ViLabelChip extends StatelessWidget {
  const ViLabelChip({
    super.key,
    required this.tag,
    this.onTap,
    this.deleteButtonShow = false,
  });

  final String tag;
  final Function()? onTap;
  final bool deleteButtonShow;

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          ViContainer(
            bgColor: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(ViSizes.borderRadiusLg),
            padding: const EdgeInsets.symmetric(
                horizontal: ViSizes.lg, vertical: ViSizes.sm),
            child: Text(
              tag,
              style: dark
                  ? ViTextTheme.darkTextTheme.bodyLarge
                      ?.copyWith(color: AppColors.white)
                  : ViTextTheme.ligthTextTheme.bodyLarge
                      ?.copyWith(color: AppColors.white),
            ),
          ),
          if (deleteButtonShow == true)
            ViRotioButton(
              size: 15,
              bgColor: Theme.of(context).primaryColor,
              child: const Icon(
                CupertinoIcons.clear,
                color: AppColors.white,
                size: 10,
              ),
            )
        ],
      ),
    );
  }
}
