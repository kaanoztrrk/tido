import 'package:TiDo/core/routes/routes.dart';
import 'package:TiDo/views/main_view/planner/planner_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widget/button/ratio_button.dart';
import '../../../../utils/Constant/sizes.dart';

class PlannerCategory extends StatelessWidget {
  const PlannerCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            ViRotioButton(
              onTap: () => context.push(ViRoutes.note_view),
              size: 70,
              child: Icon(Iconsax.archive_book),
            ),
            SizedBox(height: ViSizes.spaceBtwItems),
            Text("Notes")
          ],
        ),
        const Column(
          children: [
            ViRotioButton(
              size: 70,
              child: Icon(Iconsax.bookmark_2),
            ),
            SizedBox(height: ViSizes.spaceBtwItems),
            Text("Diary")
          ],
        ),
        Column(
          children: [
            ViRotioButton(
              onTap: () => context.push(ViRoutes.document_view),
              size: 70,
              child: const Icon(Iconsax.folder),
            ),
            const SizedBox(height: ViSizes.spaceBtwItems),
            const Text("Folder")
          ],
        ),
      ],
    );
  }
}

/*

  PlannerTile(
              onTap: () => context.push(ViRoutes.pomodoro_view),
              title: "Pomodoro",
              subTitle: "Technique",
              image: ViImages.pomodoro,
            ),
 */
