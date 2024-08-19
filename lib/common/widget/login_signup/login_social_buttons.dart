import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/auth_blocs/sign_in_bloc/sign_in_bloc.dart';
import '../../../blocs/auth_blocs/sign_in_bloc/sign_in_event.dart';
import '../../../blocs/auth_blocs/sign_in_bloc/sign_in_state.dart';
import '../../../core/l10n/l10n.dart';
import '../../../utils/Constant/image_strings.dart';
import '../../../utils/Constant/sizes.dart';
import '../../../utils/Device/device_utility.dart';
import '../../styles/container_style.dart';

class ViSocialButtons extends StatelessWidget {
  const ViSocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ViContainer(
              onTap: () {
                BlocProvider.of<SignInBloc>(context)
                    .add(GoogleSignInRequired());
              },
              height: 50,
              width: ViDeviceUtils.getScreenWidth(context) * 0.7,
              borderRadius: BorderRadius.circular(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(ViImages.googleLogo),
                  Text(AppLocalizations.of(context)!.google_sign_in),
                ],
              ),
            ),
            const SizedBox(width: ViSizes.spaceBtwItems),
            /*
         Apple Sign IN

            IconButton(
              onPressed: () {
                BlocProvider.of<SignInBloc>(context).add(
                  AppleSignInRequired(),
                );
              },
              icon: const SizedBox(
                width: ViSizes.iconLg,
                height: ViSizes.iconLg,
                child: Image(
                  image: AssetImage(ViImages.appleLogo),
                ),
              ),
            ),
         
          */
          ],
        );
      },
    );
  }
}
