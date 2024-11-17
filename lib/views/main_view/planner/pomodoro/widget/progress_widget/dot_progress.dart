import 'package:TiDo/utils/Constant/colors.dart';
import 'package:TiDo/utils/Helpers/helpers_functions.dart';
import 'package:flutter/material.dart';
import '../../../../../../utils/Device/device_utility.dart';

class DotProgress extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const DotProgress({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: ViDeviceUtils.getScreenWidth(context) * 0.3,
          color: Theme.of(context).primaryColor,
          height: 1,
        ),
        Center(
          child: SizedBox(
            width: ViDeviceUtils.getScreenWidth(context) * 0.3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(totalSteps, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    color: _getDotColor(context, index, dark),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _getBorderColor(context, index, dark),
                      width: 2,
                    ),
                  ),
                  width: _getDotSize(index),
                  height: _getDotSize(index),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }

  Color _getDotColor(BuildContext context, int index, bool dark) {
    if (index < currentStep) {
      return Theme.of(context).primaryColor; // Tamamlanmış adım
    } else if (index == currentStep) {
      return dark ? AppColors.dark : AppColors.light; // Şu an tamamlanıyor
    } else {
      return dark ? AppColors.darkerGrey : AppColors.grey; // Tamamlanmamış adım
    }
  }

  Color _getBorderColor(BuildContext context, int index, bool dark) {
    if (index < currentStep) {
      return Theme.of(context).primaryColor;
    } else {
      return dark
          ? AppColors.darkerGrey
          : AppColors.grey; // Tamamlanmamış adımın border rengi
    }
  }

  double _getDotSize(int index) {
    return index == currentStep
        ? 20
        : 15; // Şu an tamamlanıyor olan adım daha büyük
  }
}
