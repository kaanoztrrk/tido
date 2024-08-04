import 'package:flutter/material.dart';
import 'package:tido/common/styles/container_style.dart';
import 'package:tido/common/widget/button/ratio_button.dart';
import 'package:tido/utils/Constant/sizes.dart';

import '../../../utils/Constant/colors.dart';
import '../../../utils/Helpers/helpers_functions.dart';
import '../../../utils/Theme/custom_theme.dart/text_theme.dart';

class SelectedFilesTile extends StatelessWidget {
  const SelectedFilesTile({super.key, this.leading, this.title});

  final Widget? leading;
  final String? title;

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    return ViContainer(
      margin: const EdgeInsets.all(ViSizes.sm),
      borderRadius: BorderRadius.circular(30),
      height: 100,
      child: Row(
        children: [
          const SizedBox(width: ViSizes.md),
          ViRotioButton(
            bgColor: Theme.of(context).primaryColor,
            child: leading,
          ),
          const SizedBox(width: ViSizes.md),
          Text(
            title ?? "",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: dark
                ? ViTextTheme.darkTextTheme.titleMedium
                    ?.copyWith(color: AppColors.white)
                : ViTextTheme.ligthTextTheme.titleMedium
                    ?.copyWith(color: AppColors.primaryText),
          ),
        ],
      ),
    );
  }
}
