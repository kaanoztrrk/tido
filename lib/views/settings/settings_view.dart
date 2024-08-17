import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tido/blocs/auth_blocs/authentication_bloc/authentication_bloc.dart';
import 'package:tido/blocs/auth_blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:tido/blocs/auth_blocs/sign_in_bloc/sign_in_event.dart';
import 'package:tido/blocs/home_bloc/home_bloc.dart';
import 'package:tido/blocs/home_bloc/home_event.dart';
import 'package:tido/blocs/theme_bloc/theme_bloc.dart';
import 'package:tido/common/bottom_sheet/are_you_sure.dart';
import 'package:tido/common/bottom_sheet/change_language_bottom_sheet.dart';
import 'package:tido/common/styles/container_style.dart';
import 'package:tido/common/widget/Text/title.dart';
import 'package:tido/core/l10n/l10n.dart';
import 'package:tido/core/locator/locator.dart';
import 'package:tido/core/routes/routes.dart';
import 'package:tido/core/widget/user/profile_image.dart';
import 'package:tido/utils/Constant/sizes.dart';
import 'package:tido/utils/Device/device_utility.dart';
import 'package:tido/utils/Helpers/helpers_functions.dart';
import 'package:tido/utils/Snackbar/snacbar_service.dart';

import '../../blocs/auth_blocs/authentication_bloc/authentication_state.dart';
import '../../blocs/auth_blocs/sign_in_bloc/sign_in_state.dart';
import '../../blocs/theme_bloc/theme_state.dart';
import '../../utils/Constant/colors.dart';
import '../../utils/Theme/custom_theme.dart/text_theme.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>.value(value: getIt<HomeBloc>()),
        BlocProvider<AuthenticationBloc>.value(
            value: getIt<AuthenticationBloc>()),
        BlocProvider<SignInBloc>.value(value: getIt<SignInBloc>()),
        BlocProvider<ThemeBloc>.value(value: getIt<ThemeBloc>())
      ],
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(ViSizes.defaultSpace),
          child: Center(
            child: ListView(
              children: [
                BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        ViProfileImage(
                          size: ViDeviceUtils.getScreenWidth(context) * 0.3,
                          onEdit: true,
                        ),
                        const SizedBox(height: ViSizes.spaceBtwItems),
                        Text(
                            state.user?.displayName ??
                                AppLocalizations.of(context)!.unkownUser,
                            style: dark
                                ? ViTextTheme.darkTextTheme.headlineMedium
                                : ViTextTheme.ligthTextTheme.headlineMedium),
                        Text(
                          state.user?.email ??
                              AppLocalizations.of(context)!.unkownEmail,
                          style: dark
                              ? ViTextTheme.darkTextTheme.titleMedium
                                  ?.copyWith(color: AppColors.secondaryText)
                              : ViTextTheme.ligthTextTheme.titleMedium
                                  ?.copyWith(color: AppColors.secondaryText),
                        ),
                        const SizedBox(height: ViSizes.spaceBtwItems * 1.5),
                      ],
                    );
                  },
                ),
                const SizedBox(height: ViSizes.spaceBtwSections),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ViPrimaryTitle(
                      title: AppLocalizations.of(context)!.customize,
                    ),
                    const SizedBox(height: ViSizes.spaceBtwItems),
                    ViContainer(
                      borderRadius: BorderRadius.circular(20),
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () => context.push(ViRoutes.theme_view),
                            leading: const Icon(Iconsax.color_swatch),
                            title: Text(AppLocalizations.of(context)!.theme),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: ViSizes.defaultSpace),
                            child: Divider(),
                          ),
                          ListTile(
                            leading: const Icon(Iconsax.layer),
                            title: Text(AppLocalizations.of(context)!.widget),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: ViSizes.defaultSpace),
                            child: Divider(),
                          ),
                          ListTile(
                            onTap: () => ChangeLanguageBottomSheet
                                .showLanguageBottomSheet(context),
                            leading: const Icon(Iconsax.translate),
                            title: Text(AppLocalizations.of(context)!.language),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: ViSizes.defaultSpace),
                            child: Divider(),
                          ),
                          ListTile(
                            leading: const Icon(Iconsax.notification),
                            title: Text(AppLocalizations.of(context)!
                                .notification_reminder),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: ViSizes.defaultSpace),
                            child: Divider(),
                          ),
                          BlocBuilder<ThemeBloc, ThemeState>(
                            builder: (context, state) {
                              return ListTile(
                                leading: const Icon(Icons.vibration),
                                title: Text(
                                    AppLocalizations.of(context)!.task_tone),
                                trailing: Switch(
                                  inactiveThumbColor: state.primaryColor,
                                  value: false,
                                  onChanged: (value) {},
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: ViSizes.spaceBtwSections),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ViPrimaryTitle(
                        title: AppLocalizations.of(context)!.task_category),
                    const SizedBox(height: ViSizes.spaceBtwItems),
                    ViContainer(
                      borderRadius: BorderRadius.circular(20),
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () => context.push(ViRoutes.archive),
                            leading: const Icon(Iconsax.archive),
                            title: Text(AppLocalizations.of(context)!.archive),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: ViSizes.defaultSpace),
                            child: Divider(),
                          ),
                          ListTile(
                            onTap: () => context.push(ViRoutes.categories),
                            leading: const Icon(Iconsax.task_square),
                            title:
                                Text(AppLocalizations.of(context)!.categories),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: ViSizes.spaceBtwSections),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ViPrimaryTitle(
                        title: AppLocalizations.of(context)!.date_time),
                    const SizedBox(height: ViSizes.spaceBtwItems),
                    ViContainer(
                      borderRadius: BorderRadius.circular(20),
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(Iconsax.timer),
                            title:
                                Text(AppLocalizations.of(context)!.time_format),
                            subtitle: Text(
                                AppLocalizations.of(context)!.system_default),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: ViSizes.defaultSpace),
                            child: Divider(),
                          ),
                          ListTile(
                            leading: const Icon(Iconsax.calendar),
                            title:
                                Text(AppLocalizations.of(context)!.date_format),
                            subtitle: const Text("2024/07/30"),
                          ),
                          /*   const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: ViSizes.defaultSpace),
                            child: Divider(),
                          ),
                     
                          ListTile(
                            leading: const Icon(Iconsax.notification),
                            title: Text(AppLocalizations.of(context)!
                                .task_reminder_default),
                            subtitle: const Text("5 minutes before"),
                          ),
                          */
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: ViSizes.spaceBtwSections),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ViPrimaryTitle(
                        title: AppLocalizations.of(context)!.data_security),
                    const SizedBox(height: ViSizes.spaceBtwItems),
                    ViContainer(
                      borderRadius: BorderRadius.circular(20),
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () => context.push(ViRoutes.data_stroge),
                            leading: const Icon(Iconsax.data),
                            title: Text(
                                AppLocalizations.of(context)!.data_storage),
                          ),
                          /*
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: ViSizes.defaultSpace),
                            child: Divider(),
                          ),
                          ListTile(
                            onTap: () => context.push(ViRoutes.backup_location),
                            leading: const Icon(Iconsax.layer),
                            title: Text(
                              AppLocalizations.of(context)!.backup_location,
                            ),
                          ),*/
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: ViSizes.defaultSpace),
                            child: Divider(),
                          ),
                          ListTile(
                            onTap: () {
                              ViAreYouSureBottomSheet.onAreYouSureBottomSheet(
                                  context: context,
                                  icon: Iconsax.trash,
                                  onTap: () {
                                    try {
                                      BlocProvider.of<HomeBloc>(context)
                                          .add(DeleteAllTasksEvent());
                                      BlocProvider.of<HomeBloc>(context)
                                          .add(DeleteAllCategoryEvent());

                                      ViSnackbar.showSuccess(
                                          context,
                                          AppLocalizations.of(context)!
                                              .progress_complated);
                                      context.pop();
                                    } catch (e) {
                                      ViSnackbar.showError(
                                          context,
                                          AppLocalizations.of(context)!
                                              .progress_failed);
                                      context.pop();
                                    }
                                  },
                                  cancelOnTap: () => context.pop(),
                                  title: AppLocalizations.of(context)!
                                      .delete_all_title,
                                  subTitle: AppLocalizations.of(context)!
                                      .delete_all_subTitle);
                            },
                            leading: const Icon(Iconsax.trash),
                            title:
                                Text(AppLocalizations.of(context)!.clear_data),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: ViSizes.defaultSpace),
                            child: Divider(),
                          ),
                          ListTile(
                            leading: const Icon(Iconsax.password_check),
                            title: Text(AppLocalizations.of(context)!.password),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: ViSizes.spaceBtwSections),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ViPrimaryTitle(title: AppLocalizations.of(context)!.about),
                    const SizedBox(height: ViSizes.spaceBtwItems),
                    ViContainer(
                      borderRadius: BorderRadius.circular(20),
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(Iconsax.star),
                            title: Text(AppLocalizations.of(context)!.rate_us),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: ViSizes.defaultSpace),
                            child: Divider(),
                          ),
                          ListTile(
                            leading: const Icon(Iconsax.share),
                            title:
                                Text(AppLocalizations.of(context)!.share_app),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: ViSizes.defaultSpace),
                            child: Divider(),
                          ),
                          ListTile(
                            leading: const Icon(Iconsax.edit_2),
                            title: Text(AppLocalizations.of(context)!.feedback),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: ViSizes.defaultSpace),
                            child: Divider(),
                          ),
                          ListTile(
                            leading: const Icon(Iconsax.security),
                            title: Text(
                                AppLocalizations.of(context)!.privacy_policy),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: ViSizes.spaceBtwItems),
                BlocBuilder<SignInBloc, SignInState>(
                  builder: (context, state) {
                    return ListTile(
                      onTap: () {
                        BlocProvider.of<SignInBloc>(context)
                            .add(const SignOutRequired());
                      },
                      leading: const Icon(
                        Iconsax.logout,
                        color: AppColors.warning,
                      ),
                      title: Text(
                        AppLocalizations.of(context)!.log_out,
                        style: ViTextTheme.ligthTextTheme.titleLarge
                            ?.copyWith(color: AppColors.warning),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
