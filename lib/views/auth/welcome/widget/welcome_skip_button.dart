import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tido/utils/Constant/colors.dart';
import 'package:tido/utils/Constant/text_strings.dart';
import 'package:tido/utils/Helpers/helpers_functions.dart';
import 'package:tido/utils/Theme/custom_theme.dart/text_theme.dart';

import '../../../../blocs/main_bloc/main_bloc.dart';
import '../../../../blocs/main_bloc/main_event.dart';

class WelcomeSkipButton extends StatelessWidget {
  const WelcomeSkipButton({super.key});

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    return Positioned(
      top: 40,
      right: 20,
      child: TextButton(
        onPressed: () {
          context.read<MainBloc>().add(SkipPage(context));
        },
        child: Text(
          ViTexts.skip,
          style: dark
              ? ViTextTheme.ligthTextTheme.headlineSmall
                  ?.copyWith(color: AppColors.primary)
              : ViTextTheme.darkTextTheme.headlineSmall
                  ?.copyWith(color: AppColors.primary),
        ),
      ),
    );
  }
}
