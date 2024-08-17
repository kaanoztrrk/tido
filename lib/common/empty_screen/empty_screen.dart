import 'package:flutter/material.dart';
import 'package:tido/utils/Constant/sizes.dart';
import 'package:tido/utils/Helpers/helpers_functions.dart';

import '../../utils/Theme/custom_theme.dart/text_theme.dart';

class ViEmptyScreen extends StatelessWidget {
  const ViEmptyScreen(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.image,
      this.size,
      this.color});

  final String image;
  final String title;
  final String subTitle;
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(
          image: AssetImage(image),
          height: size,
          width: size,
          color: color,
        ),
        const SizedBox(height: ViSizes.lg),
        Text(
          title,
          style: dark
              ? ViTextTheme.darkTextTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                )
              : ViTextTheme.ligthTextTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
        ),
        Text(
          subTitle,
          textAlign: TextAlign.center,
          style: dark
              ? ViTextTheme.darkTextTheme.titleSmall
                  ?.copyWith(fontWeight: FontWeight.normal)
              : ViTextTheme.ligthTextTheme.titleSmall
                  ?.copyWith(fontWeight: FontWeight.normal),
        )
      ],
    );
  }
}
