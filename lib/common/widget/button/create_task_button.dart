import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tido/common/widget/button/ratio_button.dart';
import 'package:tido/core/routes/routes.dart';

class ViCreateTaskButton extends StatelessWidget {
  const ViCreateTaskButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: GestureDetector(
        onTap: () => context.push(ViRoutes.create_task),
        child: const ViRotioButton(
          child: Icon(Iconsax.add),
        ),
      ),
    );
  }
}
