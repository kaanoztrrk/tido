import 'dart:io';

import 'package:TiDo/common/widget/bottom_navigator/bottom_navigator.dart';
import 'package:TiDo/utils/bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax/iconsax.dart';

import '../../blocs/home_bloc/home_bloc.dart';
import '../../blocs/home_bloc/home_state.dart';
import '../../core/l10n/l10n.dart';
import '../../utils/Constant/colors.dart';
import '../../utils/Helpers/helpers_functions.dart';
import '../mobile/main_view/home/home_view.dart';
import '../mobile/main_view/settings/settings_view.dart';
import '../mobile/main_view/schedule/schedule_view.dart';

class MobileNavigator extends StatefulWidget {
  const MobileNavigator({
    super.key,
  });

  @override
  State<MobileNavigator> createState() => _MobileNavigatorState();
}

class _MobileNavigatorState extends State<MobileNavigator> {
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
            bottomNavigationBar: ViBottomNavigationBar(
              darkMode: dark,
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
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
                  icon: Iconsax.setting,
                  text: AppLocalizations.of(context)!.settings,
                ),
              ],
            ));
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
        return const SettingsView();
      default:
        return const Center(
          child: Text('Unknown Page'),
        );
    }
  }
}
