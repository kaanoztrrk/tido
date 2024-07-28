import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tido/utils/Constant/sizes.dart';

import '../../utils/Constant/colors.dart';
import '../../utils/Helpers/helpers_functions.dart';
import '../../utils/Theme/custom_theme.dart/text_theme.dart';

class ViTaskOptionBottomSheet {
  void showOptionBottomSheet(
    BuildContext context, {
    required VoidCallback onEdit,
    required VoidCallback onDelete,
    VoidCallback? onMarkAsComplete,
  }) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            children: [
              _itemTile(() {}, dark, Iconsax.edit_2, "Task Edit"),
              _itemTile(() {}, dark, Iconsax.trash, "Task Delete"),
              _itemTile(() {}, dark, Iconsax.tick_circle, "Task Completed"),
            ],
          ),
        );
      },
    );
  }

  GestureDetector _itemTile(
      Function()? ontap, bool dark, IconData icon, String title) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        height: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: ViSizes.md),
          child: Row(
            children: [
              Icon(
                icon,
                size: 30,
                color: AppColors.darkerGrey,
              ),
              const SizedBox(width: ViSizes.lg),
              Text(
                title,
                style: dark
                    ? ViTextTheme.darkTextTheme.titleLarge?.copyWith(
                        color: AppColors.white,
                      )
                    : ViTextTheme.ligthTextTheme.titleLarge?.copyWith(
                        color: AppColors.primaryText,
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
