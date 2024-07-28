import 'package:flutter/material.dart';
import '../../../utils/Constant/image_strings.dart';
import '../../../utils/Constant/sizes.dart';

class ViSocialButtons extends StatelessWidget {
  const ViSocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: const SizedBox(
            width: ViSizes.iconMd,
            height: ViSizes.iconMd,
            child: Image(
              image: AssetImage(ViImages.googleLogo),
            ),
          ),
        ),
        const SizedBox(width: ViSizes.spaceBtwItems),
        IconButton(
          onPressed: () {},
          icon: const SizedBox(
            width: ViSizes.iconMd,
            height: ViSizes.iconMd,
            child: Image(
              image: AssetImage(ViImages.facebookLogo),
            ),
          ),
        ),
        const SizedBox(width: ViSizes.spaceBtwItems),
        IconButton(
          onPressed: () {},
          icon: const SizedBox(
            width: ViSizes.iconMd,
            height: ViSizes.iconMd,
            child: Image(
              image: AssetImage(ViImages.appleLogo),
            ),
          ),
        ),
      ],
    );
  }
}
