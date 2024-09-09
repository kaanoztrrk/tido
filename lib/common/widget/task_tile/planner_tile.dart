import 'package:flutter/material.dart';

import '../../../utils/Constant/colors.dart';
import '../../../utils/Constant/sizes.dart';
import '../../../utils/Device/device_utility.dart';
import '../../../utils/Helpers/helpers_functions.dart';
import '../../../utils/Theme/custom_theme.dart/text_theme.dart';

class PlannerTile extends StatelessWidget {
  const PlannerTile({
    super.key,
    required this.title,
    required this.subTitle,
    required this.image,
    this.onTap,
    this.height,
  });

  final String title;
  final String subTitle;
  final String image;
  final Function()? onTap;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final dark = ViHelpersFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: height ?? ViDeviceUtils.getScreenHeigth(context) * 0.2,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(ViSizes.cardRadiusLg),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: dark
                      ? ViTextTheme.darkTextTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.lightGrey,
                        )
                      : ViTextTheme.ligthTextTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.light,
                        ),
                ),
                Text(
                  subTitle,
                  style: dark
                      ? ViTextTheme.darkTextTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.lightGrey,
                        )
                      : ViTextTheme.ligthTextTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.light,
                        ),
                ),
              ],
            ),
            Image.asset(
              image,
              width: ViDeviceUtils.getScreenHeigth(context) * 0.2,
              height: ViDeviceUtils.getScreenWidth(context) * 0.4,
            ),
          ],
        ),
      ),
    );
  }
}
