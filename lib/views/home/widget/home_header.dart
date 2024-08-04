import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tido/utils/Constant/colors.dart';
import 'package:tido/utils/Helpers/helpers_functions.dart';
import 'package:tido/utils/Theme/custom_theme.dart/text_theme.dart';

import '../../../blocs/auth_blocs/authentication_bloc/authentication_bloc.dart';
import '../../../blocs/auth_blocs/authentication_bloc/authentication_state.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);

    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        String displayName = state.user?.displayName ?? '';
        String firstName = extractFirstName(displayName);

        return Padding(
          padding: const EdgeInsets.only(right: 40),
          child: Text.rich(
            TextSpan(
              text: "Hi $firstName,\n",
              children: [
                TextSpan(
                  text: "nice to see you",
                  style: dark
                      ? ViTextTheme.darkTextTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.lightGrey,
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
          ),
        );
      },
    );
  }

  String extractFirstName(String fullName) {
    if (fullName.isEmpty) return '';
    List<String> nameParts = fullName.split(' ');
    if (nameParts.length > 1) {
      return '${nameParts[0]} ${nameParts[1]}';
    } else {
      return nameParts.first;
    }
  }
}
