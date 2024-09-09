import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widget/button/ratio_button.dart';
import '../../../../utils/Constant/sizes.dart';

class PlannerCategory extends StatelessWidget {
  const PlannerCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            ViRotioButton(
              size: 70,
              child: Icon(Iconsax.archive_book),
            ),
            SizedBox(height: ViSizes.spaceBtwItems),
            Text("Notes")
          ],
        ),
        Column(
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
              size: 70,
              child: Icon(Iconsax.receipt_text),
            ),
            SizedBox(height: ViSizes.spaceBtwItems),
            Text("Quotes")
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
