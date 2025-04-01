import 'package:TiDo/core/l10n/l10n.dart';
import 'package:TiDo/utils/Helpers/helpers_functions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/styles/container_style.dart';
import '../../../../../common/widget/button/ratio_button.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../utils/constant/colors.dart';
import '../../../../../utils/constant/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../../utils/theme/custom_theme.dart/text_theme.dart';

class CategorySearch extends StatelessWidget {
  const CategorySearch({super.key, required this.taskLength});

  final String taskLength;

  @override
  Widget build(BuildContext context) {
    final dark = ViHelpersFunctions.isDarkMode(context);
    return Row(
      children: [
        //* Category List
        Expanded(
          child: SizedBox(
            height: 50,
            child: ListView(
              padding: const EdgeInsets.only(left: 10),
              scrollDirection: Axis.horizontal,
              children: [
                ViContainer(
                  width: ViDeviceUtils.getScreenWidth(context) * 0.2,
                  height: ViDeviceUtils.getScreenHeigth(context) * 0.1,
                  borderRadius: BorderRadius.circular(ViSizes.cardRadiusLg * 2),
                  bgColor: Theme.of(context).primaryColor,
                  child: Center(
                      child: Text(
                    "${AppLocalizations.of(context)!.all_items} ($taskLength)",
                    style: ViTextTheme.darkTextTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600, color: AppColors.light),
                  )),
                )
              ],
            ),
          ),
        ),

        //* Search Button
        ViRotioButton(
          onTap: () {
            // Diğer sayfaya geçiş

            context.push(ViRoutes.search_view);
          },
          child: Icon(
            Iconsax.search_normal,
            color: dark ? AppColors.light : AppColors.dark,
          ),
        ),
        const SizedBox(width: ViSizes.sm),
      ],
    );
  }
}
