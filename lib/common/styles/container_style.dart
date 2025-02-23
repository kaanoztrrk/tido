import 'package:flutter/material.dart';

import '../../utils/Constant/colors.dart';
import '../../utils/Helpers/helpers_functions.dart';

class ViContainer extends StatelessWidget {
  const ViContainer({
    super.key,
    this.onTap,
    this.child,
    this.width,
    this.height,
    this.bgColor,
    this.borderRadius,
    this.padding,
    this.margin,
    this.decoration,
    this.alignment,
    this.gradient,
    this.borderColor,
  });

  final Function()? onTap;
  final Widget? child;
  final double? width;
  final double? height;
  final Color? bgColor;
  final Color? borderColor;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Decoration? decoration;
  final AlignmentGeometry? alignment;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);

    Color defaultBgColor =
        dark ? AppColors.dark : AppColors.lightGrey.withValues(alpha: 0.7);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: alignment,
        padding: padding,
        margin: margin,
        width: width,
        height: height,
        decoration: decoration ??
            BoxDecoration(
                color: bgColor ?? defaultBgColor,
                border:
                    Border.all(width: 2, color: borderColor ?? AppColors.white),
                borderRadius: borderRadius,
                gradient: gradient),
        child: child,
      ),
    );
  }
}
