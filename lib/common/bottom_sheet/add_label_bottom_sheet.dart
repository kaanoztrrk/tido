import 'package:flutter/material.dart';

import '../../core/l10n/l10n.dart';
import '../../utils/Constant/colors.dart';
import '../../utils/Constant/sizes.dart';
import '../../utils/Device/device_utility.dart';
import '../../utils/Helpers/helpers_functions.dart';
import '../../utils/Theme/custom_theme.dart/text_theme.dart';
import '../styles/container_style.dart';
import '../widget/button/primary_button.dart';

class AddCategoryLabelBottomSheet {
  static void showAddTagBottomSheet({
    required BuildContext context,
    required List<String> tags,
    required Function(List<String>) onTagsUpdated,
  }) {
    final TextEditingController tagController = TextEditingController();

    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        var dark = ViHelpersFunctions.isDarkMode(context);
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
                ViContainer(
                  padding: const EdgeInsets.only(left: 5, top: 10),
                  height: 65,
                  decoration: BoxDecoration(
                    color: dark ? AppColors.black : AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(),
                  ),
                  child: TextField(
                    controller: tagController,
                    decoration: InputDecoration(
                      filled: false,
                      hintText: AppLocalizations.of(context)!.add_label,
                      hintStyle: dark
                          ? ViTextTheme.darkTextTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.normal)
                          : ViTextTheme.ligthTextTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.normal),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: ViSizes.sm),
                ViPrimaryButton(
                  text: AppLocalizations.of(context)!.done,
                  height: ViDeviceUtils.getScreenHeigth(context) * 0.08,
                  onTap: () {
                    if (tagController.text.isNotEmpty) {
                      tags.add(tagController.text);
                      onTagsUpdated(tags);
                      Navigator.pop(context);
                      ViDeviceUtils.hideKeyboard(context);
                    }
                  },
                ),
                const SizedBox(height: ViSizes.sm),
              ],
            ),
          ),
        );
      },
    );
  }
}
