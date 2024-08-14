import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tido/common/widget/button/primary_button.dart';
import 'package:tido/common/widget/login_signup/login_social_buttons.dart';
import 'package:tido/core/locator/locator.dart';
import 'package:tido/core/routes/routes.dart';
import 'package:tido/utils/Constant/sizes.dart';
import 'package:tido/common/widget/login_signup/login_divider.dart';
import 'package:tido/utils/Constant/text_strings.dart';
import 'package:tido/utils/Helpers/helpers_functions.dart';
import 'package:tido/views/auth/login/widget/register_button.dart';
import '../../../blocs/auth_blocs/authentication_bloc/authentication_bloc.dart';
import '../../../blocs/auth_blocs/sign_in_bloc/sign_in_bloc.dart';
import '../../../blocs/auth_blocs/sign_in_bloc/sign_in_event.dart';
import '../../../blocs/auth_blocs/sign_in_bloc/sign_in_state.dart';
import '../../../blocs/home_bloc/home_bloc.dart';
import '../../../common/styles/container_style.dart';
import '../../../core/l10n/l10n.dart';
import '../../../utils/Constant/image_strings.dart';
import '../../../utils/Device/device_utility.dart';
import '../../../utils/Theme/custom_theme.dart/text_theme.dart';
import '../../../utils/validators/validationHelpers.dart';
import '../../../common/widget/login_signup/login_header.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool signInRequired = false;
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool obscurePassword = true;
  String? _errorMsg;

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<HomeBloc>()),
        BlocProvider.value(value: getIt<AuthenticationBloc>()),
        BlocProvider.value(value: getIt<SignInBloc>()),
      ],
      child: BlocListener<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is SignInSuccess) {
            setState(() {
              signInRequired = false;
            });
            context.push(ViRoutes.home);
          } else if (state is SignInProcess) {
            setState(() {
              signInRequired = true;
            });
          } else if (state is SignInFailure) {
            setState(
              () {
                signInRequired = false;
                _errorMsg = 'Invalid email or password';
              },
            );
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.all(ViSizes.defaultSpace),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  AuthHeader(
                    title: AppLocalizations.of(context)!.login_welcome_title,
                    subTitle:
                        AppLocalizations.of(context)!.login_welcome_subTitle,
                  ),
                  const SizedBox(height: ViSizes.spaceBtwSections * 2),
                  TextFormField(
                    controller: emailController,
                    validator: (value) =>
                        ViValidator.validateEmail(context, value),
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
                    obscureText: obscurePassword,
                    validator: (value) =>
                        ViValidator.validatePassword(context, value),
                    decoration: InputDecoration(
                      errorText: _errorMsg,
                      hintText: AppLocalizations.of(context)!.password,
                      hintStyle: dark
                          ? ViTextTheme.darkTextTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.normal)
                          : ViTextTheme.ligthTextTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.normal),
                      prefixIcon: const Icon(Iconsax.password_check),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                            if (obscurePassword) {
                              iconPassword = CupertinoIcons.eye_fill;
                            } else {
                              iconPassword = CupertinoIcons.eye_slash_fill;
                            }
                          });
                        },
                        icon: Icon(iconPassword),
                      ),
                    ),
                  ),
                  const SizedBox(height: ViSizes.spaceBtwItems),
                  GestureDetector(
                    onTap: () => context.push(ViRoutes.forgot_password),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        AppLocalizations.of(context)!.forgot_password,
                        style: dark
                            ? ViTextTheme.darkTextTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.normal)
                            : ViTextTheme.ligthTextTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  const SizedBox(height: ViSizes.spaceBtwSections),
                  ViFormDivider(dividerText: AppLocalizations.of(context)!.or),
                  const SizedBox(height: ViSizes.spaceBtwSections),
                  Center(
                    child: ViContainer(
                      onTap: () {
                        BlocProvider.of<SignInBloc>(context)
                            .add(GoogleSignInRequired());
                      },
                      bgColor: Theme.of(context).primaryColor,
                      height: 50,
                      width: ViDeviceUtils.getScreenWidth(context) * 0.7,
                      borderRadius: BorderRadius.circular(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(ViImages.googleLogo),
                          Text(
                            AppLocalizations.of(context)!.google_sign_in,
                            style: ViTextTheme.darkTextTheme.bodyLarge,
                          )
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  ViRichTexts(
                    onSignInTap: () => context.push(ViRoutes.register),
                    normalText: AppLocalizations.of(context)!.dontHaveAnAccount,
                    boldText: AppLocalizations.of(context)!.signUp,
                  ),
                  const SizedBox(height: ViSizes.spaceBtwItems),
                  !signInRequired
                      ? ViPrimaryButton(
                          text: AppLocalizations.of(context)!.signIn,
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<SignInBloc>().add(SignInRequired(
                                  emailController.text,
                                  passwordController.text));
                            }
                          },
                        )
                      : const Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
