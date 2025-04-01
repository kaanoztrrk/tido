// ignore_for_file: library_private_types_in_public_api, empty_catches

import 'package:TiDo/blocs/auth_blocs/sign_up_bloc/sign_up_event.dart';
import 'package:TiDo/data/models/user_model/models.dart';
import 'package:TiDo/utils/Snackbar/snacbar_service.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../blocs/auth_blocs/sign_up_bloc/sign_up_bloc.dart';
import '../../../../common/widget/appbar/appbar.dart';
import '../../../../common/widget/button/primary_button.dart';
import '../../../../common/widget/login_signup/login_header.dart';
import '../../../../core/l10n/l10n.dart';
import '../../../../core/routes/routes.dart';
import '../../../../utils/Constant/sizes.dart';
import 'widget/otp_textfield.dart';

class OtpView extends StatefulWidget {
  final UserModel userModel;
  final String password;
  const OtpView({super.key, required this.userModel, required this.password});

  @override
  _OtpViewState createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  @override
  Widget build(BuildContext context) {
    final otpController = TextEditingController();
    return Scaffold(
      appBar: const ViAppBar(showBackArrow: true),
      body: Padding(
        padding: const EdgeInsets.all(ViSizes.defaultSpace),
        child: Column(
          children: [
            AuthHeader(
              title: AppLocalizations.of(context)!.otp_title,
              subTitle: AppLocalizations.of(context)!.otp_subTitle,
              smallSizeSubTitle: true,
            ),
            const SizedBox(height: ViSizes.spaceBtwSections),
            OTPTextField(onChanged: (otp) {
              otpController.text = otp;
            }),
            const SizedBox(height: ViSizes.spaceBtwSections),
            ViPrimaryButton(
              text: AppLocalizations.of(context)!.otp_submit_button_text,
              onTap: () {
                try {
                  final isOtpValid =
                      EmailOTP.verifyOTP(otp: otpController.text);
                  if (isOtpValid) {
                    // OTP geçerliyse, kullanıcıyı kaydet ve login sayfasına yönlendir
                    // Bu işlem için kullanıcının kaydedilmesi gerekebilir, örneğin:
                    context
                        .read<SignUpBloc>()
                        .add(SignUpRequired(widget.userModel, widget.password));

                    context.push(ViRoutes.login);
                    ViSnackbar.showSuccess(context,
                        "Your account has been created successfully. You can log in.");
                  } else {
                    // OTP geçerli değilse
                    ViSnackbar.showError(
                        context, "Invalid OTP. Please try again.");
                  }
                } catch (e) {}
              },
            ),
          ],
        ),
      ),
    );
  }
}
