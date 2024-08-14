// ignore_for_file: library_private_types_in_public_api

import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tido/common/widget/button/primary_button.dart';
import 'package:tido/common/widget/login_signup/login_header.dart';
import 'package:tido/core/routes/routes.dart';
import 'package:tido/utils/Constant/sizes.dart';
import 'package:tido/utils/Constant/text_strings.dart';
import 'package:tido/views/auth/otp/widget/otp_textfield.dart';

import '../../../common/widget/appbar/appbar.dart';
import '../../../core/l10n/l10n.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key});

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
                EmailOTP.verifyOTP(otp: otpController.text);
                context.push(ViRoutes.home);
              },
            ),
          ],
        ),
      ),
    );
  }
}
