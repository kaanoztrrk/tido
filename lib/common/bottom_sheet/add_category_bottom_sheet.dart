import 'package:flutter/material.dart';
import '../../blocs/home_bloc/home_bloc.dart';
import '../../blocs/home_bloc/home_event.dart';
import '../../core/l10n/l10n.dart';
import '../../utils/Constant/colors.dart';
import '../../utils/Constant/sizes.dart';
import '../../utils/Device/device_utility.dart';
import '../../utils/Helpers/helpers_functions.dart';
import '../../utils/Theme/custom_theme.dart/text_theme.dart';
import '../styles/container_style.dart';
import '../widget/button/primary_button.dart';

class ViAddCategoryBottomSheet {
  static void onAddCategoryBottomSheet({
    required BuildContext context,
    required HomeBloc bloc,
    required TextEditingController controller,
  }) {
    var dark = ViHelpersFunctions.isDarkMode(context);

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
                ViContainer(
                  padding: const EdgeInsets.only(left: 5, top: 10),
                  height: 65,
                  decoration: BoxDecoration(
                    color: dark ? AppColors.black : AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(),
                  ),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      filled: false,
                      hintText: AppLocalizations.of(context)!.categories,
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
                const SizedBox(height: ViSizes.lg),
                ViPrimaryButton(
                  text: AppLocalizations.of(context)!.done,
                  height: ViDeviceUtils.getScreenHeigth(context) * 0.08,
                  onTap: () {
                    final categoryName = controller.text.trim();
                    if (categoryName.isNotEmpty) {
                      bloc.add(AddCategoryEvent(categoryName));
                    }
                    Navigator.pop(context);
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
