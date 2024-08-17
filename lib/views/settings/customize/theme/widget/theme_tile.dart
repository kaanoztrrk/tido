import 'package:flutter/material.dart';

import '../../../../../core/l10n/l10n.dart';
import '../../../../../utils/Constant/colors.dart';
import '../../../../../utils/Constant/sizes.dart';
import '../../../../../utils/Device/device_utility.dart';

class ThemeModeItem extends StatelessWidget {
  const ThemeModeItem({
    super.key,
    this.bgColor,
    this.itemColor,
    required this.title,
    this.isSelected = false,
    this.onTap,
  });

  final Color? bgColor;
  final Color? itemColor;
  final String title;
  final bool isSelected;

  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              margin: const EdgeInsets.all(ViSizes.sm),
              height: ViDeviceUtils.getScreenHeigth(context) * 0.3,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Colors.transparent,
                  width: 3,
                ),
                color: bgColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0) +
                    const EdgeInsets.only(top: ViSizes.sm),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: ViSizes.md),
                      decoration: BoxDecoration(
                        color: itemColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: ViSizes.md),
                      decoration: BoxDecoration(
                        color: itemColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 20,
                      width: ViDeviceUtils.getScreenWidth(context) * 0.2,
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        color: itemColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Text(title),
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
          GestureDetector(
            onTap: onTap,
            child: Container(
              margin: const EdgeInsets.all(ViSizes.sm),
              height: ViDeviceUtils.getScreenHeigth(context) * 0.3,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Colors.black,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: AppColors.black,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 238, 225, 225),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0) +
                        const EdgeInsets.only(top: ViSizes.sm),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: ViSizes.md),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 20,
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: ViSizes.md),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 20,
                          width: ViDeviceUtils.getScreenWidth(context) * 0.2,
                        ),
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(AppLocalizations.of(context)!.system),
        ],
      ),
    );
  }
}
