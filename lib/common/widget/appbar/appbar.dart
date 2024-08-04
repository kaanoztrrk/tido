import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tido/utils/Constant/colors.dart';

import '../../../utils/Constant/sizes.dart';
import '../../../utils/Device/device_utility.dart';
import '../button/ratio_button.dart';

class ViAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ViAppBar({
    super.key,
    this.title,
    this.showBackArrow = false,
    this.leadingIcon,
    this.leadingWidget,
    this.actions,
    this.leadingOnPressed,
    this.height,
    this.centerTitle = false,
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final Widget? leadingWidget;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final double? height;
  final bool? centerTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: ViSizes.md),
      child: AppBar(
        centerTitle: centerTitle,
        backgroundColor: AppColors.light,
        automaticallyImplyLeading: false,
        leading: showBackArrow
            ? ViRotioButton(
                onTap: () => context.pop(),
                child: const Icon(Icons.arrow_back_ios_new_rounded),
              )
            : leadingIcon != null
                ? IconButton(
                    onPressed: leadingOnPressed, icon: Icon(leadingIcon))
                : leadingWidget,
        title: title,
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(height ?? ViDeviceUtils.getAppBarHeigth());
}
