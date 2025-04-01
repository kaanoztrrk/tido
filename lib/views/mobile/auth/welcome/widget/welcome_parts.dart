// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../../../../../utils/Constant/colors.dart';
import '../../../../../utils/Constant/sizes.dart';
import '../../../../../utils/Helpers/helpers_functions.dart';

class WelcomePart extends StatelessWidget {
  const WelcomePart(
      {super.key,
      required this.image,
      required this.title,
      required this.subtitle});

  final String image, title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(ViSizes.defaultSpace),
      child: Column(
        children: [
          Image(
            image: AssetImage(
              image,
            ),
            width: ViHelpersFunctions.screenWidth(context) * 0.8,
            height: ViHelpersFunctions.screenHeigth(context) * 0.6,
          ),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: ViSizes.spaceBtwItems),
          Text(
            subtitle,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: AppColors.secondaryText),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
