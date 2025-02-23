import 'package:TiDo/utils/Constant/colors.dart';
import 'package:TiDo/utils/Constant/image_strings.dart';
import 'package:TiDo/utils/Constant/sizes.dart';
import 'package:TiDo/utils/Helpers/helpers_functions.dart';
import 'package:flutter/material.dart';

import '../../../../utils/Theme/custom_theme.dart/text_theme.dart';
import '../../../styles/container_style.dart';

class PremiumItemTile extends StatelessWidget {
  const PremiumItemTile({
    super.key,
    required this.title,
    required this.subTitle,
    required this.image,
  });

  final String title;
  final String image;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    final dark = ViHelpersFunctions.isDarkMode(context);
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: ViSizes.defaultSpace),
        child: Column(
          children: [
            SizedBox(height: ViSizes.sm),
            Image.asset(
              image,
              width: ViHelpersFunctions.screenHeigth(context) * 0.2,
              height: ViHelpersFunctions.screenHeigth(context) * 0.2,
            ),
            Text(
              title,
              style: dark
                  ? ViTextTheme.ligthTextTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600, color: AppColors.white)
                  : ViTextTheme.darkTextTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600, color: AppColors.black),
            ),
            SizedBox(height: ViSizes.sm),
            Text(
              subTitle,
              textAlign: TextAlign.center,
              style: dark
                  ? ViTextTheme.ligthTextTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600, color: AppColors.darkGrey)
                  : ViTextTheme.darkTextTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600, color: AppColors.black),
            ),
          ],
        ),
      ),
    );
  }
}
