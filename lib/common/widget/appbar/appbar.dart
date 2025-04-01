import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../utils/Constant/colors.dart';
import '../../../utils/Constant/sizes.dart';
import '../../../utils/Device/device_utility.dart';
import '../../../utils/Helpers/helpers_functions.dart';
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
    this.foregroundColor,
    this.surfaceTintColor,
    this.appBarBackgroundColor,
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final Widget? leadingWidget;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final double? height;
  final bool? centerTitle;
  final Color? foregroundColor;
  final Color? surfaceTintColor;
  final Color? appBarBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: ViSizes.md),
      child: AppBar(
        foregroundColor: foregroundColor,
        surfaceTintColor: surfaceTintColor,
        toolbarHeight: height,
        leading: showBackArrow
            ? ViRotioButton(
                onTap: () => context.pop(),
                child: const Icon(Icons.arrow_back_ios_new_rounded),
              )
            : leadingWidget,
        centerTitle: centerTitle,
        backgroundColor: appBarBackgroundColor ?? Colors.transparent,
        automaticallyImplyLeading: false,
        title: title,
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(height ?? ViDeviceUtils.getAppBarHeigth());
}
