import 'package:TiDo/common/widget/Text/title.dart';
import 'package:TiDo/common/widget/task_tile/populer_planner_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:TiDo/common/widget/appbar/home_appbar.dart';
import 'package:TiDo/utils/Constant/image_strings.dart';
import 'package:TiDo/utils/Device/device_utility.dart';
import '../../../blocs/home_bloc/home_bloc.dart';
import '../../../blocs/home_bloc/home_state.dart';
import '../../../common/widget/task_tile/planner_tile.dart';
import '../../../core/routes/routes.dart';
import '../../../utils/Constant/sizes.dart';

class PlannerView extends StatelessWidget {
  const PlannerView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: ListView(
              children: [
                ViHomeAppBar(
                  height: ViSizes.appBarHeigth * 1.2,
                  leadingOnPressed: () => context.push(ViRoutes.create_task),
                  notificationOnPressed: () =>
                      context.push(ViRoutes.notification_page),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: ViSizes.defaultSpace),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: ViSizes.spaceBtwItems),
                      PlannerTile(
                          onTap: () =>
                              context.push(ViRoutes.location_reminder_view),
                          height: ViDeviceUtils.getScreenHeigth(context) * 0.25,
                          title: "Location",
                          subTitle: "Reminder",
                          image: ViImages.traveller_image),
                      const SizedBox(height: ViSizes.spaceBtwSections),
                      const ViPrimaryTitle(title: "🔥 Populer", bigText: true),
                      const SizedBox(height: ViSizes.spaceBtwItems),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.habitList.length,
                        itemBuilder: (context, index) => PopulerPlannerTile(
                          title: state.habitList[index].title,
                          image: state.habitList[index].image ?? "",
                          onTap: () {
                            if (state.habitList[index].title ==
                                "Pomodoro Technique") {
                              context.push(ViRoutes.pomodoro_view);
                            } else {
                              context.push(ViRoutes.habit_view,
                                  extra: state.habitList[index]);
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
