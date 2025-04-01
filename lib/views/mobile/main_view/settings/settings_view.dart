import 'package:TiDo/common/widget/item_tile/premium/no_ads_tile.dart';
import 'package:TiDo/common/widget/item_tile/premium/premium_tile.dart';
import 'package:TiDo/data/services/date_formetter_service.dart';
import 'package:TiDo/utils/bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../blocs/auth_blocs/authentication_bloc/authentication_bloc.dart';
import '../../../../blocs/auth_blocs/authentication_bloc/authentication_state.dart';
import '../../../../blocs/auth_blocs/sign_in_bloc/sign_in_bloc.dart';
import '../../../../blocs/auth_blocs/sign_in_bloc/sign_in_event.dart';
import '../../../../blocs/auth_blocs/sign_in_bloc/sign_in_state.dart';
import '../../../../blocs/home_bloc/home_bloc.dart';
import '../../../../blocs/home_bloc/home_event.dart';
import '../../../../blocs/theme_bloc/theme_bloc.dart';
import '../../../../blocs/theme_bloc/theme_event.dart';
import '../../../../blocs/theme_bloc/theme_state.dart';
import '../../../../common/styles/container_style.dart';
import '../../../../common/widget/Text/title.dart';
import '../../../../core/l10n/l10n.dart';
import '../../../../core/locator/locator.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widget/user/profile_image.dart';
import '../../../../utils/Constant/colors.dart';
import '../../../../utils/Constant/sizes.dart';
import '../../../../utils/Device/device_utility.dart';
import '../../../../utils/Helpers/helpers_functions.dart';
import '../../../../utils/Snackbar/snacbar_service.dart';
import '../../../../utils/Theme/custom_theme.dart/text_theme.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
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
          child: ListView(
            children: [
              _buildProfileSection(context),
              _buildSettingsSection(context),
              _buildTaskCategorySection(context),
              _buildDateTimeSection(context),
              _buildDataSecuritySection(context),
              _buildAboutSection(context),
              _buildLogoutTile(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Column(
          children: [
            ViProfileImage(
              size: ViDeviceUtils.getScreenWidth(context) * 0.3,
              onTap: () => context.push(ViRoutes.profile_view),
            ),
            const SizedBox(height: ViSizes.spaceBtwItems),
            Text(
                state.user?.displayName ??
                    AppLocalizations.of(context)!.unkownUser,
                style: ViTextTheme.darkTextTheme.headlineMedium
                    ?.copyWith(color: dark ? AppColors.white : AppColors.dark)),
            Text(state.user?.email ?? AppLocalizations.of(context)!.unkownEmail,
                style: ViTextTheme.darkTextTheme.titleMedium
                    ?.copyWith(color: AppColors.secondaryText)),
            const SizedBox(height: ViSizes.spaceBtwItems * 1.5),
          ],
        );
      },
    );
  }

  Widget _buildSettingsSection(BuildContext context) {
    return _buildSection(
      title: AppLocalizations.of(context)!.customize,
      children: [
        _buildListTile(
            context,
            Iconsax.brush_1,
            AppLocalizations.of(context)!.theme,
            () => context.push(ViRoutes.theme_view)),
        _buildListTile(
            context,
            Iconsax.color_swatch,
            AppLocalizations.of(context)!.theme_mode,
            () =>
                ViBottomSheet.showSwitchThemeModeBottomSheet(context: context)),
        _buildListTile(
            context,
            Iconsax.translate,
            AppLocalizations.of(context)!.language,
            () => ViBottomSheet.showLanguageBottomSheet(context)),
      ],
    );
  }

  Widget _buildTaskCategorySection(BuildContext context) {
    return _buildSection(
      title: AppLocalizations.of(context)!.task_category,
      children: [
        _buildListTile(
            context,
            Iconsax.archive,
            AppLocalizations.of(context)!.archive,
            () => context.push(ViRoutes.archive)),
        _buildListTile(
            context,
            Iconsax.document,
            AppLocalizations.of(context)!.documents,
            () => context.push(ViRoutes.document_view)),
      ],
    );
  }

  Widget _buildDateTimeSection(BuildContext context) {
    return _buildSection(
      title: AppLocalizations.of(context)!.date_time,
      children: [
        _buildListTile(context, Iconsax.timer,
            AppLocalizations.of(context)!.time_format, () => {}),
        _buildListTile(context, Iconsax.calendar,
            AppLocalizations.of(context)!.date_format, () => {}),
      ],
    );
  }

  Widget _buildDataSecuritySection(BuildContext context) {
    return _buildSection(
      title: AppLocalizations.of(context)!.data_security,
      children: [
        _buildListTile(
            context,
            Iconsax.data,
            AppLocalizations.of(context)!.data_storage,
            () => context.push(ViRoutes.data_stroge)),
        _buildListTile(context, Iconsax.trash,
            AppLocalizations.of(context)!.clear_data, () => {}),
      ],
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    return _buildSection(
      title: AppLocalizations.of(context)!.about,
      children: [
        _buildListTile(
            context,
            Iconsax.security,
            AppLocalizations.of(context)!.privacy_policy,
            () => context.push(ViRoutes.privacy_policy)),
      ],
    );
  }

  Widget _buildLogoutTile(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {
        return ListTile(
          onTap: () =>
              BlocProvider.of<SignInBloc>(context).add(SignOutRequired()),
          leading: const Icon(Iconsax.logout, color: AppColors.warning),
          title: Text(
            AppLocalizations.of(context)!.log_out,
            style: ViTextTheme.ligthTextTheme.titleLarge
                ?.copyWith(color: AppColors.warning),
          ),
        );
      },
    );
  }

  Widget _buildSection(
      {required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ViPrimaryTitle(title: title),
        const SizedBox(height: ViSizes.spaceBtwItems),
        ViContainer(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            children: children,
          ),
        ),
        const SizedBox(height: ViSizes.spaceBtwSections),
      ],
    );
  }

  Widget _buildListTile(
      BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon),
      title: Text(title),
    );
  }
}
