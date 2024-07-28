import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tido/utils/Constant/colors.dart';
import 'package:tido/utils/Theme/custom_theme.dart/text_theme.dart';
import 'package:tido/views/home/widget/time_button.dart';

import '../../../utils/Constant/sizes.dart';
import '../../../utils/Device/device_utility.dart';
import '../button/ratio_button.dart';

class ViHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ViHomeAppBar({
    super.key,
    this.title,
    this.showBackArrow = false,
    this.leadingIcon,
    this.leadingWidget,
    this.actions,
    this.leadingOnPressed,
    this.height,
    this.createTaskButton = false,
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final Widget? leadingWidget;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final double? height;
  final bool? createTaskButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: ViSizes.md),
      child: Container(
        margin: const EdgeInsets.only(top: ViSizes.md),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (createTaskButton == false)
              leadingWidget ?? Container()
            else
              ViTimeButton(
                onTap: leadingOnPressed,
                timeText: "8:03",
                icon: Iconsax.add,
              ),
            const Row(
              children: [
                ViRotioButton(
                  child: Icon(Iconsax.notification, size: ViSizes.iconLg),
                ),
                SizedBox(width: ViSizes.spaceBtwItems / 2),
                ViRotioButton(
                  hasImage: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(height ?? ViDeviceUtils.getAppBarHeigth());
}
