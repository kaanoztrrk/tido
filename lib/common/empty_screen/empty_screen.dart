import 'package:flutter/material.dart';

import 'package:tido/utils/Constant/image_strings.dart';
import 'package:tido/utils/Helpers/helpers_functions.dart';

import '../../utils/Theme/custom_theme.dart/text_theme.dart';

class ViEmptyScreen extends StatelessWidget {
  const ViEmptyScreen(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.image});

  final String image;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    return Column(
      children: [
        Image(image: AssetImage(image)),
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
