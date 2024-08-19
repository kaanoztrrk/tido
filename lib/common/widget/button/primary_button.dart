import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/theme_bloc/theme_bloc.dart';
import '../../../blocs/theme_bloc/theme_state.dart';
import '../../../core/locator/locator.dart';
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
                  color: Theme.of(context).primaryColor),
              child: Text(text,
                  style: ViTextTheme.darkTextTheme.headlineSmall
                      ?.copyWith(color: AppColors.light)),
            ),
          );
        },
      ),
    );
  }
}
