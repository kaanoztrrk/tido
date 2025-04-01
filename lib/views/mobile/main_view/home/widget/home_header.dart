import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../blocs/auth_blocs/authentication_bloc/authentication_bloc.dart';
import '../../../../../blocs/auth_blocs/authentication_bloc/authentication_state.dart';
import '../../../../../core/l10n/l10n.dart';
import '../../../../../utils/Constant/colors.dart';
import '../../../../../utils/Constant/sizes.dart';
import '../../../../../utils/Helpers/helpers_functions.dart';
import '../../../../../utils/Theme/custom_theme.dart/text_theme.dart';

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
          padding: const EdgeInsets.only(right: 40) +
              const EdgeInsets.all(ViSizes.defaultSpace),
          child: Text.rich(
            TextSpan(
              //${AppLocalizations.of(context)!.hi_text} $firstName,\n
              text: "${AppLocalizations.of(context)!.hi_text} $firstName\n",
              children: [
                TextSpan(
                  text: AppLocalizations.of(context)!.nice_to_see_you,
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
    return nameParts.first;
  }
}
