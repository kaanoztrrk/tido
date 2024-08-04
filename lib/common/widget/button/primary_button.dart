import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tido/blocs/theme_bloc/theme_bloc.dart';
import 'package:tido/core/locator/locator.dart';

import '../../../blocs/theme_bloc/theme_state.dart';
import '../../../utils/Constant/colors.dart';
import '../../../utils/Helpers/helpers_functions.dart';
import '../../../utils/Theme/custom_theme.dart/text_theme.dart';

class ViPrimaryButton extends StatelessWidget {
  const ViPrimaryButton({
    super.key,
    required this.text,
    this.onTap,
    this.height = 70,
    this.width,
    this.smallText = false,
  });

  final String text;
  final Function()? onTap;
  final double? height;
  final double? width;
  final bool smallText;

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    var textStyle = dark
        ? (smallText
            ? ViTextTheme.ligthTextTheme.titleMedium
            : ViTextTheme.ligthTextTheme.headlineMedium)
        : (smallText
            ? ViTextTheme.darkTextTheme.titleMedium
            : ViTextTheme.darkTextTheme.headlineMedium);

    return BlocProvider.value(
      value: getIt<ThemeBloc>(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: onTap,
            child: Container(
              alignment: Alignment.center,
              width: width ?? ViHelpersFunctions.screenWidth(context),
              height: height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  gradient: state.primaryGradientButton),
              child: Text(
                text,
                style: textStyle,
              ),
            ),
          );
        },
      ),
    );
  }
}
