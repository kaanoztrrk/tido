import 'package:TiDo/utils/Snackbar/snacbar_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../../blocs/auth_blocs/sign_in_bloc/sign_in_bloc.dart';
import '../../../blocs/auth_blocs/sign_in_bloc/sign_in_event.dart';
import '../../../common/widget/appbar/appbar.dart';
import '../../../common/widget/button/primary_button.dart';
import '../../../common/widget/login_signup/login_header.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/routes/routes.dart';
import '../../../utils/Constant/sizes.dart';
import '../../../utils/Constant/text_strings.dart';
import '../../../utils/Helpers/helpers_functions.dart';
import '../../../utils/Theme/custom_theme.dart/text_theme.dart';
import '../../../utils/validators/validationHelpers.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    final signInBloc = context.read<SignInBloc>();

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
            Form(
              key: _formKey, // Assign the form key
              child: TextFormField(
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
                onSaved: (value) {
                  if (value != null) {
                    signInBloc.add(ForgotPasswordRequired(email: value));
                  }
                },
              ),
            ),
            const SizedBox(height: ViSizes.spaceBtwSections),
            ViPrimaryButton(
              text: AppLocalizations.of(context)!.continue_text,
              onTap: () {
                if (_formKey.currentState?.validate() ?? false) {
                  _formKey.currentState?.save();
                  context.push(ViRoutes.login);
                  ViSnackbar.showInfo(context,
                      "The password reset link has been sent to your email. Please check.");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
