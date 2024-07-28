import 'package:flutter/material.dart';

import '../../../utils/Constant/sizes.dart';
import '../../../utils/Helpers/helpers_functions.dart';
import '../../../utils/Theme/custom_theme.dart/text_theme.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
    required this.title,
    required this.subTitle,
    this.titleStyle,
    this.subTitleStyle,
    this.smallSizeTitle = false,
    this.smallSizeSubTitle = false,
  });

  final String title, subTitle;
  final TextStyle? titleStyle;
  final TextStyle? subTitleStyle;
  final bool smallSizeTitle;
  final bool smallSizeSubTitle;

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);

    // Varsayılan stil değerleri
    final defaultTitleStyle = dark
        ? (smallSizeTitle
            ? ViTextTheme.darkTextTheme.headlineSmall
            : ViTextTheme.darkTextTheme.headlineLarge)
        : (smallSizeTitle
            ? ViTextTheme.ligthTextTheme.headlineSmall
            : ViTextTheme.ligthTextTheme.headlineLarge);

    final defaultSubTitleStyle = dark
        ? (smallSizeSubTitle
            ? ViTextTheme.darkTextTheme.headlineSmall
            : ViTextTheme.darkTextTheme.headlineLarge)
        : (smallSizeSubTitle
            ? ViTextTheme.ligthTextTheme.headlineSmall
            : ViTextTheme.ligthTextTheme.headlineLarge);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: titleStyle ??
              defaultTitleStyle?.copyWith(fontSize: smallSizeTitle ? null : 36),
        ),
        const SizedBox(height: ViSizes.spaceBtwItems),
        Text(
          subTitle,
          style: subTitleStyle ??
              defaultSubTitleStyle?.copyWith(fontWeight: FontWeight.w100),
        ),
      ],
    );
  }
}
