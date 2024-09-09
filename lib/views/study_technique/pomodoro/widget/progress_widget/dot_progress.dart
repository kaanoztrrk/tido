import 'package:TiDo/utils/Constant/colors.dart';
import 'package:TiDo/utils/Helpers/helpers_functions.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/Device/device_utility.dart';

class DotProgress extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const DotProgress({
    Key? key,
    required this.currentStep,
    required this.totalSteps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: ViDeviceUtils.getScreenWidth(context) * 0.3,
          color: AppColors.primary,
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
                    color: _getDotColor(index, dark),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _getBorderColor(index, dark),
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

  Color _getDotColor(int index, bool dark) {
    if (index < currentStep) {
      return AppColors.primary; // Tamamlanmış adım
    } else if (index == currentStep) {
      return dark ? AppColors.dark : AppColors.light; // Şu an tamamlanıyor
    } else {
      return dark ? AppColors.darkerGrey : AppColors.grey; // Tamamlanmamış adım
    }
  }

  Color _getBorderColor(int index, bool dark) {
    if (index < currentStep) {
      return AppColors
          .primary; // Tamamlanmış ve tamamlanmakta olan adımın border rengi
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
