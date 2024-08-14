import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tido/common/widget/appbar/appbar.dart';
import 'package:tido/common/widget/button/primary_button.dart';
import 'package:tido/common/widget/login_signup/login_header.dart';
import 'package:tido/core/l10n/l10n.dart';
import 'package:tido/core/routes/routes.dart';
import 'package:tido/utils/Constant/sizes.dart';
import 'package:tido/utils/Constant/text_strings.dart';
import '../../../utils/Helpers/helpers_functions.dart';
import '../../../utils/Theme/custom_theme.dart/text_theme.dart';
import '../../../utils/validators/validationHelpers.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const ViAppBar(showBackArrow: true),
      body: Padding(
        padding: const EdgeInsets.all(ViSizes.defaultSpace),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthHeader(
              smallSizeSubTitle: true,
              title: AppLocalizations.of(context)!.forgot_password_title,
              subTitle: AppLocalizations.of(context)!.forgot_password_subTitle,
            ),
            const SizedBox(height: ViSizes.spaceBtwSections),
            TextFormField(
              validator: (value) => ViValidator.validateEmail(context, value),
              decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.direct_right),
                hintText: ViTexts.email,
                hintStyle: dark
                    ? ViTextTheme.darkTextTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.normal)
                    : ViTextTheme.ligthTextTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.normal),
              ),
            ),
            const SizedBox(height: ViSizes.spaceBtwSections),
            ViPrimaryButton(
              text: AppLocalizations.of(context)!.continue_text,
              onTap: () => context.push(ViRoutes.login),
            ),
          ],
        ),
      ),
    );
  }
}
