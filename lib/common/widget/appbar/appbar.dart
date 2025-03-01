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
    var dark = ViHelpersFunctions.isDarkMode(context);
    // Sabit renkler kullanmak, kaydırıldıkça rengin değişmemesini sağlar.
    Color appBarColor = dark ? AppColors.dark : AppColors.light;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: ViSizes.md),
      child: AppBar(
        toolbarHeight: height,
        leading: showBackArrow
            ? ViRotioButton(
                onTap: () => context.pop(),
                child: const Icon(Icons.arrow_back_ios_new_rounded),
              )
            : leadingWidget,
        centerTitle: centerTitle,
        backgroundColor: appBarColor, // Sabit arkaplan rengi
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
