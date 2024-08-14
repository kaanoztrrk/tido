import 'package:email_otp/email_otp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tido/blocs/auth_blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:tido/common/widget/button/primary_button.dart';
import 'package:tido/common/widget/login_signup/login_social_buttons.dart';
import 'package:tido/core/routes/routes.dart';
import 'package:tido/utils/Constant/sizes.dart';
import 'package:tido/common/widget/login_signup/login_divider.dart';
import 'package:tido/utils/Constant/text_strings.dart';
import 'package:tido/views/auth/login/widget/register_button.dart';
import 'package:tido/views/auth/register/register_form.dart';
import '../../../blocs/auth_blocs/sign_up_bloc/sign_up_event.dart';
import '../../../blocs/auth_blocs/sign_up_bloc/sign_up_state.dart';
import '../../../common/widget/login_signup/login_header.dart';
import '../../../core/l10n/l10n.dart';
import '../../../data/models/user_model/models.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          // Handle navigation or other side effects
        } else if (state is SignUpFailure) {
          // Show a snackbar or other error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(state.message ??
                    AppLocalizations.of(context)!.sign_up_failed)),
          );
        }
      },
      child: BlocBuilder<SignUpBloc, SignUpState>(
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: const EdgeInsets.all(ViSizes.defaultSpace),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  AuthHeader(
                      title:
                          AppLocalizations.of(context)!.register_welcome_title,
                      subTitle: AppLocalizations.of(context)!
                          .register_welcome_subTitle),
                  const SizedBox(height: ViSizes.spaceBtwSections),
                  ViRegisterForm(
                    formKey: formKey,
                    emailController: emailController,
                    nameController: nameController,
                    obscureTextValue: state.obscurePassword,
                    passwordController: passwordController,
                    suffixIcon: state.obscurePassword
                        ? CupertinoIcons.eye_fill
                        : CupertinoIcons.eye_slash_fill,
                    passwordObscureFunction: () {
                      context
                          .read<SignUpBloc>()
                          .add(TogglePasswordVisibility());
                    },
                  ),
                  const SizedBox(height: ViSizes.spaceBtwSections),
                  ViFormDivider(dividerText: AppLocalizations.of(context)!.or),
                  const SizedBox(height: ViSizes.spaceBtwSections),
                  const Spacer(),
                  ViRichTexts(
                    onSignInTap: () => context.pop(),
                    normalText:
                        AppLocalizations.of(context)!.doYouHaveAnAccount,
                    boldText: AppLocalizations.of(context)!.signIn,
                  ),
                  const SizedBox(height: ViSizes.spaceBtwItems),
                  ViPrimaryButton(
                    text: AppLocalizations.of(context)!.signUp,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        UserModel myUser = UserModel.empty;
                        myUser = myUser.copyWith(
                          email: emailController.text,
                          name: nameController.text,
                          profileImageUrl: null,
                        );
                        context.read<SignUpBloc>().add(
                              SignUpRequired(myUser, passwordController.text),
                            );
                        EmailOTP.sendOTP(email: emailController.text);
                        context.push(ViRoutes.otp);
                      }
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
