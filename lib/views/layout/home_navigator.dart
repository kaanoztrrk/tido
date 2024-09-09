import 'package:TiDo/views/main_view/planner/planner_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax/iconsax.dart';

import '../../blocs/home_bloc/home_bloc.dart';
import '../../blocs/home_bloc/home_state.dart';
import '../../core/l10n/l10n.dart';
import '../../utils/Constant/colors.dart';
import '../../utils/Helpers/helpers_functions.dart';
import '../main_view/home/home_view.dart';
import '../main_view/settings/settings_view.dart';
import '../document/document_view.dart';
import '../main_view/schedule/schedule_view.dart';

class HomeNavigator extends StatefulWidget {
  const HomeNavigator({
    super.key,
  });

  @override
  State<HomeNavigator> createState() => _HomeNavigatorState();
}

class _HomeNavigatorState extends State<HomeNavigator> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: _getPage(_selectedIndex),
          ),
          bottomNavigationBar: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16) +
                const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            decoration: BoxDecoration(
              color: dark
                  ? AppColors.bottomNavigatorBackgroundDark
                  : AppColors.bottomNavigatorBackground,
              borderRadius: BorderRadius.circular(40),
            ),
            child: GNav(
              gap: 8,
              activeColor: dark ? AppColors.light : AppColors.dark,
              iconSize: 24,
              tabBackgroundColor: dark
                  ? AppColors.bottomNavigatorItemActiveBgDark
                  : AppColors.bottomNavigatorItemActiveBg,
              padding: const EdgeInsets.all(12),
              duration: const Duration(milliseconds: 400),
              tabs: [
                GButton(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  icon: Iconsax.home,
                  text: AppLocalizations.of(context)!.home,
                ),
                GButton(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  icon: Iconsax.calendar,
                  text: AppLocalizations.of(context)!.schedule,
                ),
                GButton(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  icon: Iconsax.document,
                  text: AppLocalizations.of(context)!.planner,
                ),
                GButton(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  icon: Iconsax.setting,
                  text: AppLocalizations.of(context)!.settings,
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        );
      },
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const HomeView();
      case 1:
        return const ScheduleView();
      case 2:
        return const PlannerView();
      case 3:
        return const SettingsView();
      default:
        return const Center(
          child: Text('Unknown Page'),
        );
    }
  }
}
