import 'package:flutter/material.dart';

import '../../../utils/Constant/colors.dart';
import '../../../utils/Constant/image_strings.dart';
import '../../../utils/Helpers/helpers_functions.dart';

class ViRotioButton extends StatelessWidget {
  const ViRotioButton({
    super.key,
    this.onTap,
    this.child,
    this.bgColor,
    this.bgImage,
    this.isNetworkImage = false,
    this.hasImage = false,
    this.size = 55,
  });

  final VoidCallback? onTap;
  final Widget? child;
  final Color? bgColor;
  final ImageProvider? bgImage;
  final bool isNetworkImage;
  final bool hasImage;
  final double? size;

  @override
  Widget build(BuildContext context) {
    bool dark = ViHelpersFunctions.isDarkMode(context);

    Color defaultBgColor =
        dark ? AppColors.dark : AppColors.lightGrey.withOpacity(0.7);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: bgColor ?? defaultBgColor,
          image: hasImage
              ? DecorationImage(
                  image: isNetworkImage
                      ? bgImage ?? const AssetImage(ViImages.default_user)
                      : bgImage ?? const AssetImage(ViImages.default_user),
                  fit: BoxFit.cover,
                )
              : null,
          border: Border.all(width: 2, color: AppColors.white),
        ),
        child: child,
      ),
    );
  }
}
