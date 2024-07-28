import 'package:flutter/material.dart';
import 'package:tido/utils/Constant/colors.dart';
import 'package:tido/utils/Constant/image_strings.dart';

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

  final Function()? onTap;
  final Widget? child;
  final Color? bgColor;
  final String? bgImage;
  final bool isNetworkImage;
  final bool hasImage;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: bgColor ?? AppColors.ligthGrey.withOpacity(0.7),
          image: hasImage
              ? DecorationImage(
                  image: isNetworkImage
                      ? NetworkImage(bgImage ?? "")
                      : AssetImage(bgImage ?? ViImages.default_user)
                          as ImageProvider,
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
