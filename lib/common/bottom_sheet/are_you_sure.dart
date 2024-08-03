import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tido/blocs/home_bloc/home_bloc.dart';
import 'package:tido/common/widget/Text/title.dart';
import 'package:tido/common/widget/button/primary_button.dart';
import 'package:tido/utils/Constant/text_strings.dart';
import '../../blocs/home_bloc/home_event.dart';
import '../../utils/Constant/colors.dart';
import '../../utils/Constant/sizes.dart';
import '../../utils/Device/device_utility.dart';
import '../../utils/Helpers/helpers_functions.dart';
import '../../utils/Theme/custom_theme.dart/text_theme.dart';
import '../styles/container_style.dart';

class ViAreYouSureBottomSheet {
  static void onAreYouSureBottomSheet({
    required BuildContext context,
    required IconData icon,
    Color? iconColor,
    required VoidCallback onTap,
    required VoidCallback cancelOnTap,
    required String title,
    required String subTitle,
  }) {
    var dark = ViHelpersFunctions.isDarkMode(context);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 16.0,
              right: 16.0,
              top: 16.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: ViSizes.iconLg * 2,
                  color: iconColor ?? AppColors.primary,
                ),
                SizedBox(height: ViSizes.spaceBtwItems),
                ViPrimaryTitle(
                  title: title,
                ),
                SizedBox(height: ViSizes.spaceBtwItems),
                ViPrimaryTitle(
                  title: subTitle,
                  secondTextColor: AppColors.secondaryText,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: ViSizes.spaceBtwItems),
                ViPrimaryButton(
                  text: ViTexts.done,
                  onTap: onTap,
                ),
                MaterialButton(
                  onPressed: cancelOnTap,
                  child: Text("Cancel"),
                ),
                SizedBox(height: ViSizes.spaceBtwItems),
              ],
            ),
          ),
        );
      },
    );
  }
}
