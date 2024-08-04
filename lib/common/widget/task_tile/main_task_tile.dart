import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tido/common/styles/container_style.dart';
import 'package:tido/common/widget/button/ratio_button.dart';
import 'package:tido/common/widget/button/swiper_button.dart';
import 'package:tido/utils/Constant/sizes.dart';
import 'package:tido/utils/Helpers/helpers_functions.dart';
import 'package:tido/utils/Theme/custom_theme.dart/text_theme.dart';
import '../../../utils/Constant/colors.dart';

class HomeMainTaskTile extends StatelessWidget {
  const HomeMainTaskTile({
    super.key,
    required this.timer,
    required this.title,
    required this.isCompleted,
    this.onSwipe,
    this.onTap,
  });

  final Widget? timer;
  final String title;
  final Function()? onSwipe;
  final Function()? onTap;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.all(ViSizes.defaultSpace / 2),
      margin: const EdgeInsets.only(bottom: 30, top: 20),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradientButton,
        borderRadius: BorderRadius.circular(ViSizes.borderRadiusLg * 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Timer
          ViContainer(
            borderRadius: BorderRadius.circular(ViSizes.borderRadiusLg * 2),
            height: 60,
            bgColor: AppColors.ligthGrey.withOpacity(0.7),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: ViSizes.md),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Iconsax.timer_1,
                    color: dark ? AppColors.dark : AppColors.white,
                  ),
                  Container(child: timer),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                  vertical: ViSizes.defaultSpace * 2),
              alignment: Alignment.bottomLeft,
              child: Text(
                title,
                style: dark
                    ? ViTextTheme.ligthTextTheme.headlineLarge
                        ?.copyWith(fontWeight: FontWeight.w600)
                    : ViTextTheme.darkTextTheme.headlineLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ViSwiperButton(
                onSwipe: onSwipe,
                isCompleted: isCompleted,
              ),
              ViRotioButton(
                onTap: onTap,
                size: 70,
                bgColor: AppColors.white,
                child: const Icon(Iconsax.edit_2),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
