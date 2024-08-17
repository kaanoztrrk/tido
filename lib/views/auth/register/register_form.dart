import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/Constant/sizes.dart';
import '../../../../utils/Helpers/helpers_functions.dart';
import '../../../../utils/Theme/custom_theme.dart/text_theme.dart';
import '../../../../utils/validators/validationHelpers.dart';
import '../../../core/l10n/l10n.dart';

class ViRegisterForm extends StatelessWidget {
  const ViRegisterForm({
    super.key,
    this.formKey,
    this.nameController,
    this.emailController,
    this.passwordController,
    this.passwordObscureFunction,
    required this.suffixIcon,
    this.obscureTextValue,
  });

  final Key? formKey;
  final TextEditingController? nameController;
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  final Function()? passwordObscureFunction;
  final IconData suffixIcon;
  final bool? obscureTextValue;
  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);

    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Iconsax.user),
              hintText: AppLocalizations.of(context)!.name,
              hintStyle: dark
                  ? ViTextTheme.darkTextTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.normal)
                  : ViTextTheme.ligthTextTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.normal),
            ),
          ),
          const SizedBox(height: ViSizes.spaceBtwItems),
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
          const SizedBox(height: ViSizes.spaceBtwItems),
          TextFormField(
            controller: passwordController,
            obscureText: obscureTextValue ?? false,
            validator: (value) => ViValidator.validatePassword(context, value),
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.password,
              hintStyle: dark
                  ? ViTextTheme.darkTextTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.normal)
                  : ViTextTheme.ligthTextTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.normal),
              prefixIcon: const Icon(Iconsax.password_check),
              suffixIcon: IconButton(
                onPressed: passwordObscureFunction,
                icon: Icon(suffixIcon),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
