import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tido/common/widget/button/create_task_button.dart';
import 'package:tido/views/home/widget/time_button.dart';

import '../../../core/widget/user/profile_image.dart';
import '../../../utils/Constant/sizes.dart';
import '../../../utils/Device/device_utility.dart';
import '../button/ratio_button.dart';

class ViHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ViHomeAppBar({
    super.key,
    this.title,
    this.height,
    this.actions,
    this.leadingIcon,
    this.leadingWidget,
    this.leadingOnPressed,
    this.notificationOnPressed,
    this.showBackArrow = false,
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

  final VoidCallback? notificationOnPressed;

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
              const ViCreateTaskButton(),
            Row(
              children: [
                ViRotioButton(
                  onTap: notificationOnPressed,
                  child: const Icon(Iconsax.notification, size: ViSizes.iconLg),
                ),
                const SizedBox(width: ViSizes.spaceBtwItems / 2),
                const ViProfileImage(),
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
