import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tido/blocs/auth_blocs/authentication_bloc/authentication_bloc.dart';
import 'package:tido/blocs/auth_blocs/authentication_bloc/authentication_event.dart';
import 'package:tido/blocs/auth_blocs/authentication_bloc/authentication_state.dart';
import 'package:tido/common/bottom_sheet/are_you_sure.dart';
import 'package:tido/common/bottom_sheet/change_language_bottom_sheet.dart';

import '../../../blocs/localization_bloc/localization_bloc.dart';
import '../../../blocs/localization_bloc/localization_state.dart';
import '../../../common/styles/container_style.dart';
import '../../../common/widget/Text/title.dart';
import '../../../common/widget/appbar/appbar.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/widget/user/profile_image.dart';
import '../../../utils/Constant/colors.dart';
import '../../../utils/Constant/sizes.dart';
import '../../../utils/Device/device_utility.dart';

import '../../../utils/Snackbar/snacbar_service.dart';
import '../../../utils/Theme/custom_theme.dart/text_theme.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key, this.user});

  final User? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ViAppBar(
        showBackArrow: true,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.profile,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(ViSizes.defaultSpace),
          child: Column(
            children: [
              Column(
                children: [
                  ViProfileImage(
                    size: ViDeviceUtils.getScreenWidth(context) * 0.3,
                    onEdit: true,
                  ),
                  const SizedBox(height: ViSizes.spaceBtwSections),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ViPrimaryTitle(
                        title:
                            AppLocalizations.of(context)!.personal_information,
                      ),
                      const SizedBox(height: ViSizes.spaceBtwItems),
                      ViContainer(
                        borderRadius: BorderRadius.circular(20),
                        child: Column(
                          children: [
                            BlocBuilder<AuthenticationBloc,
                                AuthenticationState>(
                              builder: (context, state) {
                                return Column(
                                  children: [
                                    ListTile(
                                      leading: const Icon(Iconsax.personalcard),
                                      title: Text(
                                          AppLocalizations.of(context)!.name),
                                      trailing: Text(
                                        state.user?.displayName.toString() ??
                                            "",
                                        style: ViTextTheme
                                            .ligthTextTheme.titleSmall
                                            ?.copyWith(
                                                color: AppColors.darkerGrey),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: ViSizes.defaultSpace),
                                      child: Divider(),
                                    ),
                                    ListTile(
                                      leading: const Icon(Iconsax.direct_right),
                                      title: Text(
                                          AppLocalizations.of(context)!.email),
                                      trailing: Text(
                                        state.user?.email ?? "",
                                        style: ViTextTheme
                                            .ligthTextTheme.titleSmall
                                            ?.copyWith(
                                                color: AppColors.darkerGrey),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            /*
                          
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: ViSizes.defaultSpace),
                              child: Divider(),
                            ),
                            ListTile(
                              leading: const Icon(Iconsax.password_check),
                              title:
                                  Text(AppLocalizations.of(context)!.password),
                              onTap: () {},
                            ),
                           */
                            BlocBuilder<LocalizationBloc, LocalizationState>(
                              builder: (context, state) {
                                return Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: ViSizes.defaultSpace),
                                      child: Divider(),
                                    ),
                                    ListTile(
                                      onTap: () => ChangeLanguageBottomSheet
                                          .showLanguageBottomSheet(context),
                                      leading: const Icon(Iconsax.translate),
                                      title: Text(AppLocalizations.of(context)!
                                          .language),
                                      trailing: state.selectedLanguage.image
                                          .image(height: 32, width: 32),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: ViSizes.spaceBtwSections),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ViPrimaryTitle(
                        title: AppLocalizations.of(context)!.detailes_text,
                      ),
                      const SizedBox(height: ViSizes.spaceBtwItems),
                      ViContainer(
                        borderRadius: BorderRadius.circular(20),
                        child: Column(
                          children: [
                            ListTile(
                              leading: const Icon(Iconsax.message_question),
                              title:
                                  Text(AppLocalizations.of(context)!.ask_help),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: ViSizes.defaultSpace),
                              child: Divider(),
                            ),
                            BlocBuilder<AuthenticationBloc,
                                AuthenticationState>(
                              builder: (context, state) {
                                return ListTile(
                                  onTap: () async {
                                    ViAreYouSureBottomSheet
                                        .onAreYouSureBottomSheet(
                                      context: context,
                                      icon: Iconsax.trash,
                                      title: AppLocalizations.of(context)!
                                          .delete_all_title,
                                      subTitle: AppLocalizations.of(context)!
                                          .delete_all_subTitle,
                                      onTap: () async {
                                        try {
                                          BlocProvider.of<AuthenticationBloc>(
                                                  context)
                                              .add(DeleteUser(state.user?.uid));

                                          ViSnackbar.showSuccess(
                                            context,
                                            AppLocalizations.of(context)!
                                                .progress_complated,
                                          );
                                          // Uygulamayı kapat
                                          SystemNavigator.pop();
                                        } catch (e) {
                                          ViSnackbar.showError(
                                            context,
                                            AppLocalizations.of(context)!
                                                .progress_failed,
                                          );
                                        }
                                      },
                                      cancelOnTap: () => context.pop(),
                                    );
                                  },
                                  leading: const Icon(Iconsax.profile_delete,
                                      color: AppColors.warning),
                                  title: Text(
                                    AppLocalizations.of(context)!
                                        .delete_account,
                                    style: TextStyle(color: AppColors.warning),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
