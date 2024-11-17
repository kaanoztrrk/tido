import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/l10n/l10n.dart';
import '../../../utils/Constant/colors.dart';

class ViBottomNavigationBar extends StatelessWidget {
  final bool darkMode;
  final int? selectedIndex;
  final ValueChanged<int>? onTabChange;
  final List<GButton> tabs;

  const ViBottomNavigationBar({
    Key? key,
    required this.darkMode,
    this.selectedIndex,
    this.onTabChange,
    required this.tabs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16) +
          const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      decoration: BoxDecoration(
        color: darkMode
            ? AppColors.bottomNavigatorBackgroundDark
            : AppColors.bottomNavigatorBackground,
        borderRadius: BorderRadius.circular(40),
      ),
      child: GNav(
        gap: 8,
        activeColor: darkMode ? AppColors.light : AppColors.dark,
        iconSize: 24,
        tabBackgroundColor: darkMode
            ? AppColors.bottomNavigatorItemActiveBgDark
            : AppColors.bottomNavigatorItemActiveBg,
        padding: const EdgeInsets.all(12),
        duration: const Duration(milliseconds: 400),
        tabs: tabs,
        selectedIndex: selectedIndex ?? 0,
        onTabChange: onTabChange,
      ),
    );
  }
}
