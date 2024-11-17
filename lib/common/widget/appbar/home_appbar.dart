import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/routes/routes.dart';
import '../../../core/widget/user/profile_image.dart';
import '../../../utils/Constant/sizes.dart';
import '../../../utils/Device/device_utility.dart';
import '../button/create_button.dart';
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
        height: height,
        margin: const EdgeInsets.only(top: ViSizes.md),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (showBackArrow == true)
              ViRotioButton(
                onTap: () => context.pop(),
                child: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
            if (createTaskButton == false)
              leadingWidget ?? Container()
            else
              ViCreateButton(
                icon: Iconsax.add,
                onTap: () => context.push(ViRoutes.create_task),
              ),
            const SizedBox(width: ViSizes.spaceBtwItems / 2),
            Row(
              children: actions ??
                  [
                    ViRotioButton(
                      onTap: notificationOnPressed,
                      child: const Icon(Iconsax.notification),
                    ),
                    const SizedBox(width: ViSizes.sm),
                    ViProfileImage(
                      onTap: () => context.push(ViRoutes.profile_view),
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
