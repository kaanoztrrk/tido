import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/auth_blocs/authentication_bloc/authentication_bloc.dart';
import '../../../../blocs/auth_blocs/authentication_bloc/authentication_state.dart';
import '../../../../utils/Constant/colors.dart';
import '../../../../utils/Helpers/helpers_functions.dart';
import '../../../../utils/Theme/custom_theme.dart/text_theme.dart';

class NoteHeader extends StatelessWidget {
  const NoteHeader({super.key});

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);

    double screenWidth = MediaQuery.of(context).size.width;

    double fontSize = screenWidth * 0.3;
    if (fontSize > 56) fontSize = 56;

    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(right: screenWidth * 0.1),
          child: Text.rich(
            TextSpan(
              text: "My\n",
              children: [
                TextSpan(
                  text: "Notes",
                  style: dark
                      ? ViTextTheme.darkTextTheme.headlineLarge?.copyWith(
                          fontSize: fontSize,
                          fontWeight: FontWeight.w500,
                          color: AppColors.lightGrey,
                        )
                      : ViTextTheme.ligthTextTheme.headlineLarge?.copyWith(
                          fontSize: fontSize,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondaryText,
                        ),
                ),
              ],
              style: dark
                  ? ViTextTheme.darkTextTheme.headlineLarge?.copyWith(
                      color: AppColors.white,
                      fontSize: fontSize,
                    )
                  : ViTextTheme.ligthTextTheme.headlineLarge?.copyWith(
                      color: AppColors.primaryText,
                      fontSize: fontSize,
                    ),
            ),
          ),
        );
      },
    );
  }
}
