import 'package:TiDo/common/widget/Text/title.dart';
import 'package:TiDo/common/widget/task_tile/populer_planner_tile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:TiDo/common/widget/appbar/home_appbar.dart';
import 'package:TiDo/utils/Constant/image_strings.dart';
import 'package:TiDo/utils/Device/device_utility.dart';
import '../../../common/widget/task_tile/planner_tile.dart';
import '../../../core/routes/routes.dart';
import '../../../utils/Constant/sizes.dart';
import 'widget/planner_category.dart';

class PlannerView extends StatelessWidget {
  const PlannerView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: ViHomeAppBar(
          height: ViSizes.appBarHeigth * 1.5,
          leadingOnPressed: () => context.push(ViRoutes.create_task),
          notificationOnPressed: () => context.push(ViRoutes.notification_page),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: ViSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: ViSizes.spaceBtwSections),
              PlannerTile(
                  onTap: () => context.push(ViRoutes.location_reminder_view),
                  height: ViDeviceUtils.getScreenHeigth(context) * 0.25,
                  title: "Location",
                  subTitle: "Reminder",
                  image: ViImages.traveller_image),
              const SizedBox(height: ViSizes.spaceBtwSections),
              const PlannerCategory(),
              const SizedBox(height: ViSizes.spaceBtwSections),
              const ViPrimaryTitle(title: "🔥 Populer", bigText: true),
              const SizedBox(height: ViSizes.spaceBtwItems),
              PopulerPlannerTile(
                  onTap: () => context.push(ViRoutes.pomodoro_view),
                  title: "Pomodoro",
                  subTitle: "technique",
                  image: ViImages.pomodoro)
            ],
          ),
        ),
      ),
    );
  }
}
