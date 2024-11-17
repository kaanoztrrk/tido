import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/routes/routes.dart';
import '../../../utils/Constant/colors.dart';
import '../../../utils/Helpers/helpers_functions.dart';
import 'ratio_button.dart';

class ViCreateButton extends StatelessWidget {
  const ViCreateButton({super.key, this.onTap, required this.icon});

  final Function()? onTap;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: ViRotioButton(
          child: Icon(
            icon,
            color: dark ? AppColors.light : AppColors.dark,
          ),
        ),
      ),
    );
  }
}
