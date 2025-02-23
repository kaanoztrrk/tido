import 'package:TiDo/utils/Constant/image_strings.dart';
import 'package:flutter/material.dart';

import '../../../../utils/Constant/colors.dart';
import '../../../../utils/Constant/sizes.dart';
import '../../../../utils/Device/device_utility.dart';
import '../../../../utils/Helpers/helpers_functions.dart';
import '../../../../utils/Theme/custom_theme.dart/text_theme.dart';

class NoAdsTile extends StatelessWidget {
  const NoAdsTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = ViHelpersFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () {
        //     ViBottomSheet.showNoAdsBottomSheet(context);
      },
      child: Container(
        width: double.infinity,
        height: ViDeviceUtils.getScreenHeigth(context) * 0.175,
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
                  "Enjoy\nNo Ads",
                  style: dark
                      ? ViTextTheme.darkTextTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.lightGrey,
                        )
                      : ViTextTheme.ligthTextTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.light,
                        ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(ViSizes.defaultSpace),
              decoration: BoxDecoration(
                  color: AppColors.yellow.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(500)),
              child: Image.asset(
                ViImages.noAds,
                width: ViDeviceUtils.getScreenHeigth(context) * 0.1,
                height: ViDeviceUtils.getScreenWidth(context) * 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
