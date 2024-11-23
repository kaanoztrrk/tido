import 'package:TiDo/core/routes/routes.dart';
import 'package:TiDo/utils/Constant/image_strings.dart';
import 'package:TiDo/utils/bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/Constant/colors.dart';
import '../../../utils/Constant/sizes.dart';
import '../../../utils/Device/device_utility.dart';
import '../../../utils/Helpers/helpers_functions.dart';
import '../../../utils/Theme/custom_theme.dart/text_theme.dart';

class PremiumTile extends StatelessWidget {
  const PremiumTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = ViHelpersFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () {
        ViBottomSheet.showPremiumBottomSheet(context);
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
                  "Subscrible\nTo Premium",
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
                  color: AppColors.yellow.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(500)),
              child: Image.asset(
                ViImages.premium,
                width: ViDeviceUtils.getScreenHeigth(context) * 0.05,
                height: ViDeviceUtils.getScreenWidth(context) * 0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
