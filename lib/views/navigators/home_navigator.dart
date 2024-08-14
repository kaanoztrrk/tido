import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tido/utils/Constant/colors.dart';
import 'package:tido/utils/Helpers/helpers_functions.dart';
import 'package:tido/views/home/home_view.dart';

import '../../blocs/home_bloc/home_bloc.dart';
import '../../blocs/home_bloc/home_state.dart';
import '../personalization/settings/settings_view.dart';
import '../document/document_view.dart';
import '../schedule/schedule_view.dart';

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
              tabs: const [
                GButton(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  icon: Iconsax.home,
                  text: 'Home',
                ),
                GButton(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  icon: Iconsax.calendar,
                  text: 'Schedule',
                ),
                GButton(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  icon: Iconsax.document,
                  text: 'Documents',
                ),
                GButton(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  icon: Iconsax.setting,
                  text: 'Settings',
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
        return const DocumentView();
      case 3:
        return const SettingsView();
      default:
        return const Center(
          child: Text('Unknown Page'),
        );
    }
  }
}
