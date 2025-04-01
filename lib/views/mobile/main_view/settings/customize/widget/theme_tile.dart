import 'package:TiDo/common/styles/container_style.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../core/l10n/l10n.dart';
import '../../../../../../utils/Constant/colors.dart';
import '../../../../../../utils/Constant/sizes.dart';
import '../../../../../../utils/Device/device_utility.dart';

class ThemeModeItem extends StatelessWidget {
  const ThemeModeItem({
    super.key,
    this.bgColor,
    this.itemColor,
    required this.title,
    this.isSelected = false,
    this.onTap,
    required this.icon,
  });

  final Color? bgColor;
  final IconData icon;
  final Color? itemColor;
  final String title;
  final bool isSelected;

  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          ViContainer(
            onTap: onTap,
            height: ViDeviceUtils.getScreenHeigth(context) * 0.15,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ViSizes.borderRadiusMd),
              border: Border.all(
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Colors.transparent,
                width: 3,
              ),
            ),
            child: Icon(
              icon,
              size: ViSizes.buttonHeigth,
            ),
          ),
          const SizedBox(height: ViSizes.lg),
          Text(title),
          const SizedBox(height: ViSizes.lg)
        ],
      ),
    );
  }
}

class ThemeModeSystemItem extends StatelessWidget {
  const ThemeModeSystemItem({
    super.key,
    this.isSelected = false,
    this.onTap,
  });

  final bool isSelected;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          ViContainer(
            onTap: onTap,
            height: ViDeviceUtils.getScreenHeigth(context) * 0.15,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ViSizes.borderRadiusMd),
              border: Border.all(
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Colors.transparent,
                width: 3,
              ),
            ),
            child: Icon(
              Iconsax.setting_2,
              size: ViSizes.buttonHeigth,
            ),
          ),
          const SizedBox(height: ViSizes.lg),
          Text(AppLocalizations.of(context)!.system),
          const SizedBox(height: ViSizes.lg)
        ],
      ),
    );
  }
}
