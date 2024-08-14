import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tido/common/widget/button/ratio_button.dart';
import 'package:tido/core/routes/routes.dart';
import 'package:tido/utils/Constant/colors.dart';

import '../../../utils/Helpers/helpers_functions.dart';

class ViCreateTaskButton extends StatelessWidget {
  const ViCreateTaskButton({super.key});

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
        onTap: () => context.push(ViRoutes.create_task),
        child: ViRotioButton(
          child: Icon(
            Iconsax.add,
            color: dark ? AppColors.light : AppColors.dark,
          ),
        ),
      ),
    );
  }
}
