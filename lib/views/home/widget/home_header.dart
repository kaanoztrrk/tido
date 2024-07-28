import 'package:flutter/material.dart';
import 'package:tido/utils/Constant/colors.dart';
import 'package:tido/utils/Helpers/helpers_functions.dart';
import 'package:tido/utils/Theme/custom_theme.dart/text_theme.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    return Text.rich(
      TextSpan(
        text: "Hi $name ",
        children: [
          TextSpan(
            text: "nice to\nsee you",
            style: dark
                ? ViTextTheme.darkTextTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.ligthGrey,
                  )
                : ViTextTheme.ligthTextTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondaryText,
                  ),
          ),
        ],
        style: dark
            ? ViTextTheme.darkTextTheme.headlineLarge
                ?.copyWith(color: AppColors.white)
            : ViTextTheme.ligthTextTheme.headlineLarge
                ?.copyWith(color: AppColors.primaryText),
      ),
    );
  }
}
