import 'package:flutter/material.dart';
import 'package:tido/common/widget/Text/title.dart';
import 'package:tido/common/widget/button/primary_button.dart';
import 'package:tido/utils/Constant/text_strings.dart';
import '../../core/l10n/l10n.dart';
import '../../utils/Constant/colors.dart';
import '../../utils/Constant/sizes.dart';

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
    showModalBottomSheet(
      showDragHandle: true,
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
                  color: iconColor ?? Theme.of(context).primaryColor,
                ),
                const SizedBox(height: ViSizes.spaceBtwItems),
                ViPrimaryTitle(title: title),
                const SizedBox(height: ViSizes.spaceBtwItems),
                ViPrimaryTitle(
                  title: subTitle,
                  textColor: AppColors.secondaryText,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: ViSizes.spaceBtwItems),
                ViPrimaryButton(
                  text: ViTexts.done,
                  onTap: onTap,
                ),
                MaterialButton(
                  onPressed: cancelOnTap,
                  child: Text(AppLocalizations.of(context)!.cancel),
                ),
                const SizedBox(height: ViSizes.spaceBtwItems),
              ],
            ),
          ),
        );
      },
    );
  }
}
