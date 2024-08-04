import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tido/common/widget/Text/title.dart';
import 'package:tido/common/widget/appbar/appbar.dart';
import 'package:tido/utils/Constant/colors.dart';
import 'package:tido/utils/Constant/sizes.dart';

import '../../common/styles/container_style.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ViAppBar(
        showBackArrow: true,
        centerTitle: true,
        title: ViPrimaryTitle(title: "Notification"),
      ),
      body: Expanded(
          child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return ViContainer(
            borderRadius: BorderRadius.circular(20),
            margin: const EdgeInsets.symmetric(
                horizontal: ViSizes.defaultSpace,
                vertical: ViSizes.spaceBtwItems / 2),
            padding: const EdgeInsets.all(ViSizes.defaultSpace / 2),
            child: ListTile(
              leading:
                  Icon(Iconsax.message, color: Theme.of(context).primaryColor),
              title: ViPrimaryTitle(title: "Notification Title"),
              subtitle: ViPrimaryTitle(
                title: "Notification Subtitle",
                secondTextColor: AppColors.secondaryText,
              ),
            ),
          );
        },
      )),
    );
  }
}
