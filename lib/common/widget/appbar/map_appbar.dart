import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/routes/routes.dart';
import '../../../core/widget/user/profile_image.dart';
import '../../../utils/Constant/sizes.dart';
import '../../../utils/Device/device_utility.dart';
import '../button/create_task_button.dart';
import '../button/ratio_button.dart';

class ViMapAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ViMapAppBar({
    super.key,
    this.title,
    this.height,
    this.actions,
    this.leadingIcon,
    this.leadingWidget,
    this.settingsOnPressed,
    this.notificationOnPressed,
    this.showBackArrow = false,
    this.createTaskButton = false,
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final Widget? leadingWidget;
  final List<Widget>? actions;
  final VoidCallback? settingsOnPressed;
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
            const SizedBox(width: ViSizes.spaceBtwItems / 2),
            Row(
              children: [
                ViRotioButton(
                  onTap: settingsOnPressed,
                  child: const Icon(Iconsax.setting),
                ),
                const SizedBox(width: ViSizes.sm),
                ViProfileImage(
                  onTap: () => context.push(ViRoutes.profile_view),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(height ?? ViDeviceUtils.getAppBarHeigth());
}
