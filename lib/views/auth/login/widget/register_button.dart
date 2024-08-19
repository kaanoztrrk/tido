import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../utils/Constant/colors.dart';
import '../../../../utils/Helpers/helpers_functions.dart';
import '../../../../utils/Theme/custom_theme.dart/text_theme.dart';

class ViRichTexts extends StatelessWidget {
  const ViRichTexts({
    super.key,
    this.onSignInTap,
    this.normalText,
    this.boldText,
  });

  final VoidCallback? onSignInTap;
  final String? normalText;
  final String? boldText;

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            children: [
              if (normalText != null)
                TextSpan(
                  text: normalText,
                  style: dark
                      ? ViTextTheme.darkTextTheme.titleLarge
                          ?.copyWith(color: AppColors.darkgrey)
                      : ViTextTheme.ligthTextTheme.titleLarge
                          ?.copyWith(color: AppColors.darkgrey),
                ),
              if (boldText != null)
                TextSpan(
                  text: boldText,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = onSignInTap,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
