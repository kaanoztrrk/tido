import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tido/blocs/auth_blocs/authentication_bloc/authentication_bloc.dart';
import 'package:tido/blocs/auth_blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:tido/blocs/auth_blocs/sign_in_bloc/sign_in_event.dart';
import 'package:tido/blocs/home_bloc/home_bloc.dart';
import 'package:tido/common/styles/container_style.dart';
import 'package:tido/common/widget/Text/title.dart';
import 'package:tido/common/widget/button/primary_button.dart';
import 'package:tido/common/widget/button/ratio_button.dart';
import 'package:tido/core/locator/locator.dart';
import 'package:tido/utils/Constant/sizes.dart';
import 'package:tido/utils/Device/device_utility.dart';
import 'package:tido/utils/Helpers/helpers_functions.dart';

import '../../../blocs/auth_blocs/authentication_bloc/authentication_state.dart';
import '../../../blocs/auth_blocs/sign_in_bloc/sign_in_state.dart';
import '../../../utils/Constant/colors.dart';
import '../../../utils/Theme/custom_theme.dart/text_theme.dart';

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
        BlocProvider<SignInBloc>.value(value: getIt<SignInBloc>())
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
                        Stack(
                          children: [
                            ViRotioButton(
                              size:
                                  ViDeviceUtils.getScreenWidth(context) * 0.25,
                            ),
                          ],
                        ),
                        const SizedBox(height: ViSizes.spaceBtwItems),
                        Text(
                          state.user?.displayName ?? "Unkown User",
                          style: dark
                              ? ViTextTheme.darkTextTheme.headlineMedium
                                  ?.copyWith(color: AppColors.primaryText)
                              : ViTextTheme.ligthTextTheme.headlineMedium
                                  ?.copyWith(color: AppColors.primaryText),
                        ),
                        Text(
                          state.user?.email ?? "Unkown Email",
                          style: dark
                              ? ViTextTheme.darkTextTheme.titleMedium
                                  ?.copyWith(color: AppColors.secondaryText)
                              : ViTextTheme.ligthTextTheme.titleMedium
                                  ?.copyWith(color: AppColors.secondaryText),
                        ),
                        const SizedBox(height: ViSizes.spaceBtwItems),
                        const ViPrimaryButton(
                          text: "Edit Profile",
                          height: 50,
                          width: 120,
                          smallText: true,
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: ViSizes.spaceBtwSections),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ViPrimaryTitle(title: "CUSTOMIZE"),
                    const SizedBox(height: ViSizes.spaceBtwItems),
                    ViContainer(
                      borderRadius: BorderRadius.circular(20),
                      child: Column(
                        children: [
                          const ListTile(
                            leading: Icon(Iconsax.color_swatch),
                            title: Text("Theme"),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: ViSizes.defaultSpace),
                            child: Divider(),
                          ),
                          const ListTile(
                            leading: Icon(Iconsax.layer),
                            title: Text("Widget"),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: ViSizes.defaultSpace),
                            child: Divider(),
                          ),
                          const ListTile(
                            leading: Icon(Iconsax.translate),
                            title: Text("Language"),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: ViSizes.defaultSpace),
                            child: Divider(),
                          ),
                          const ListTile(
                            leading: Icon(Iconsax.notification),
                            title: Text("Notification & Reminder"),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: ViSizes.defaultSpace),
                            child: Divider(),
                          ),
                          ListTile(
                            leading: const Icon(Icons.vibration),
                            title: const Text("Task completion tone"),
                            trailing: Switch(
                              value: false,
                              onChanged: (value) {},
                            ),
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
                    const ViPrimaryTitle(title: "TASK & CATEGORY"),
                    const SizedBox(height: ViSizes.spaceBtwItems),
                    ViContainer(
                      borderRadius: BorderRadius.circular(20),
                      child: const Column(
                        children: [
                          ListTile(
                            leading: Icon(Iconsax.archive),
                            title: Text("Archive"),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: ViSizes.defaultSpace),
                            child: Divider(),
                          ),
                          ListTile(
                            leading: Icon(Iconsax.firstline),
                            title: Text("Task Sorting Options"),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: ViSizes.defaultSpace),
                            child: Divider(),
                          ),
                          ListTile(
                            leading: Icon(Iconsax.task_square),
                            title: Text("Categories"),
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
                    const ViPrimaryTitle(title: "DATE & TIME"),
                    const SizedBox(height: ViSizes.spaceBtwItems),
                    ViContainer(
                      borderRadius: BorderRadius.circular(20),
                      child: const Column(
                        children: [
                          ListTile(
                            leading: Icon(Iconsax.timer),
                            title: Text("Time Format"),
                            subtitle: Text("System default"),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: ViSizes.defaultSpace),
                            child: Divider(),
                          ),
                          ListTile(
                            leading: Icon(Iconsax.calendar),
                            title: Text("Date Format"),
                            subtitle: Text("2024/07/30"),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: ViSizes.defaultSpace),
                            child: Divider(),
                          ),
                          ListTile(
                            leading: Icon(Iconsax.notification),
                            title: Text("Task reminder default"),
                            subtitle: Text("5 minutes before"),
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
                    const ViPrimaryTitle(title: "DATA & SECURITY "),
                    const SizedBox(height: ViSizes.spaceBtwItems),
                    ViContainer(
                      borderRadius: BorderRadius.circular(20),
                      child: const Column(
                        children: [
                          ListTile(
                            leading: Icon(Iconsax.data),
                            title: Text("Data Storage"),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: ViSizes.defaultSpace),
                            child: Divider(),
                          ),
                          ListTile(
                            leading: Icon(Iconsax.layer),
                            title: Text("Backup Location"),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: ViSizes.defaultSpace),
                            child: Divider(),
                          ),
                          ListTile(
                            leading: Icon(Iconsax.trash),
                            title: Text("Clear Data"),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: ViSizes.defaultSpace),
                            child: Divider(),
                          ),
                          ListTile(
                            leading: Icon(Iconsax.password_check),
                            title: Text("Password"),
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
                    const ViPrimaryTitle(title: "ABOUT"),
                    const SizedBox(height: ViSizes.spaceBtwItems),
                    ViContainer(
                      borderRadius: BorderRadius.circular(20),
                      child: const Column(
                        children: [
                          ListTile(
                            leading: Icon(Iconsax.star),
                            title: Text("Rate us"),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: ViSizes.defaultSpace),
                            child: Divider(),
                          ),
                          ListTile(
                            leading: Icon(Iconsax.share),
                            title: Text("Share app"),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: ViSizes.defaultSpace),
                            child: Divider(),
                          ),
                          ListTile(
                            leading: Icon(Iconsax.edit_2),
                            title: Text("Feedback"),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: ViSizes.defaultSpace),
                            child: Divider(),
                          ),
                          ListTile(
                            leading: Icon(Iconsax.security),
                            title: Text("Privacy Policy"),
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
                        "Log Out",
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
