import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widget/appbar/appbar.dart';
import '../../../../common/widget/button/primary_button.dart';
import '../../../../common/widget/login_signup/login_header.dart';
import '../../../../core/l10n/l10n.dart';
import '../../../../core/routes/routes.dart';
import '../../../../utils/Constant/sizes.dart';
import '../../../../utils/Helpers/helpers_functions.dart';
import '../../../../utils/Theme/custom_theme.dart/text_theme.dart';
import '../../../../utils/validators/validationHelpers.dart';

class ValidateEmailView extends StatelessWidget {
  const ValidateEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    final emailController = TextEditingController();
    return Scaffold(
      appBar: const ViAppBar(showBackArrow: true),
      body: Padding(
        padding: const EdgeInsets.all(ViSizes.defaultSpace),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthHeader(
              smallSizeSubTitle: true,
              title: AppLocalizations.of(context)!.email_validation_title,
              subTitle: AppLocalizations.of(context)!.email_validation_subTitle,
            ),
            const SizedBox(height: ViSizes.spaceBtwSections),
            TextFormField(
              controller: emailController,
              validator: (value) => ViValidator.validateEmail(context, value),
              decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.direct_right),
                hintText: AppLocalizations.of(context)!.email,
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
                onTap: () {
                  context.push(ViRoutes.otp, extra: emailController);
                }),
          ],
        ),
      ),
    );
  }
}
