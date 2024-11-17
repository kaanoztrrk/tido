import 'package:flutter/material.dart';

import '../../../utils/Constant/colors.dart';
import '../../../utils/Constant/sizes.dart';
import '../../../utils/Device/device_utility.dart';
import '../../../utils/Helpers/helpers_functions.dart';
import '../../../utils/Theme/custom_theme.dart/text_theme.dart';

class PopulerPlannerTile extends StatelessWidget {
  const PopulerPlannerTile({
    super.key,
    required this.title,
    required this.image,
    this.onTap,
    this.height,
  });

  final String title;
  final String image;
  final Function()? onTap;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final dark = ViHelpersFunctions.isDarkMode(context);

    // İlk kelimeyi ayırma işlemi
    final splitTitle = title.split(' ');
    final firstWord = splitTitle.isNotEmpty ? splitTitle[0] : '';
    final remainingTitle =
        splitTitle.length > 1 ? title.substring(firstWord.length + 1) : '';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: ViSizes.defaultSpace / 2),
        width: double.infinity,
        height: height ?? ViDeviceUtils.getScreenHeigth(context) * 0.15,
        decoration: BoxDecoration(
          color: dark ? AppColors.black.withOpacity(0.5) : AppColors.white,
          borderRadius: BorderRadius.circular(ViSizes.cardRadiusLg),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Gölgenin rengi
              blurRadius: 6, // Gölgenin yayılma miktarı
              offset: const Offset(0, 4), // Gölgenin yönü (x, y)
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              image,
              width: ViDeviceUtils.getScreenHeigth(context) * 0.2,
              height: ViDeviceUtils.getScreenWidth(context) * 0.2,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  firstWord,
                  style: dark
                      ? ViTextTheme.darkTextTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.lightGrey,
                        )
                      : ViTextTheme.ligthTextTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.black,
                        ),
                ),
                Text(
                  remainingTitle,
                  style: dark
                      ? ViTextTheme.darkTextTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.lightGrey,
                        )
                      : ViTextTheme.ligthTextTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
