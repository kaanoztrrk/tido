import 'package:TiDo/common/styles/container_style.dart';
import 'package:TiDo/data/models/habit_model/habit_model.dart';
import 'package:TiDo/utils/Constant/sizes.dart';
import 'package:TiDo/utils/Device/device_utility.dart';
import 'package:TiDo/views/habit/widget/circle_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../common/widget/appbar/home_appbar.dart';
import '../../common/widget/button/ratio_button.dart';
import '../../utils/Constant/colors.dart';
import '../../utils/Helpers/helpers_functions.dart';
import '../../utils/Theme/custom_theme.dart/text_theme.dart';

class HabitView extends StatelessWidget {
  const HabitView({super.key, required this.habit});

  final HabitModel habit;

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: ViSizes.appBarHeigth * 2,
              floating: false,
              backgroundColor: Colors.transparent,
              flexibleSpace: ViHomeAppBar(
                showBackArrow: true,
                height: ViSizes.appBarHeigth * 1.5,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(ViSizes.defaultSpace),
                    child: Column(
                      children: [
                        if (index == 0) ...[
                          Text(
                            habit.description ?? "",
                            style: dark
                                ? ViTextTheme.darkTextTheme.headlineLarge
                                    ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.lightGrey,
                                  )
                                : ViTextTheme.ligthTextTheme.headlineLarge
                                    ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.lightGrey,
                                  ),
                          ),
                          const SizedBox(height: ViSizes.defaultSpace * 3),
                          ViContainer(
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(
                                  ViSizes.cardRadiusLg * 2),
                            ),
                            width: double.infinity,
                            height:
                                ViHelpersFunctions.screenHeigth(context) * 0.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withValues(alpha: 0.5),
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(
                                              ViSizes.cardRadiusLg),
                                          topRight: Radius.circular(
                                              ViSizes.cardRadiusLg))),
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                        ViSizes.defaultSpace),
                                    child: Row(
                                      children: [
                                        const ViRotioButton(
                                          child: Icon(Iconsax.calendar_1),
                                        ),
                                        const SizedBox(width: ViSizes.md),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Date & Time",
                                              style: dark
                                                  ? ViTextTheme
                                                      .darkTextTheme.titleMedium
                                                      ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          AppColors.lightGrey,
                                                    )
                                                  : ViTextTheme.ligthTextTheme
                                                      .titleMedium
                                                      ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColors.black,
                                                    ),
                                            ),
                                            Text(
                                              habit.startDate.toString(),
                                              style: dark
                                                  ? ViTextTheme.darkTextTheme
                                                      .headlineSmall
                                                      ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color:
                                                          AppColors.lightGrey,
                                                    )
                                                  : ViTextTheme.ligthTextTheme
                                                      .headlineSmall
                                                      ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: AppColors.black,
                                                    ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(
                                      ViSizes.defaultSpace),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Goals Previews",
                                          style: dark
                                              ? ViTextTheme
                                                  .darkTextTheme.headlineSmall
                                                  ?.copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.lightGrey,
                                                )
                                              : ViTextTheme
                                                  .ligthTextTheme.headlineSmall
                                                  ?.copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.black,
                                                )),
                                      const SizedBox(height: ViSizes.lg),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: ViCircularProgress(
                                                progress: 0.1,
                                                size: ViDeviceUtils
                                                        .getScreenWidth(
                                                            context) *
                                                    0.2),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ListTile(
                                                  title: Text(
                                                      " %${habit.completionPercentage.toString()}",
                                                      style: dark
                                                          ? ViTextTheme
                                                              .darkTextTheme
                                                              .headlineSmall
                                                              ?.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: AppColors
                                                                  .lightGrey,
                                                            )
                                                          : ViTextTheme
                                                              .ligthTextTheme
                                                              .headlineSmall
                                                              ?.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: AppColors
                                                                  .black,
                                                            )),
                                                  subtitle: Text(
                                                      "Progress Task",
                                                      style: dark
                                                          ? ViTextTheme
                                                              .darkTextTheme
                                                              .titleLarge
                                                              ?.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              color: AppColors
                                                                  .lightGrey,
                                                            )
                                                          : ViTextTheme
                                                              .ligthTextTheme
                                                              .titleLarge
                                                              ?.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              color: AppColors
                                                                  .black,
                                                            )),
                                                ),
                                                const Divider(),
                                                ListTile(
                                                  title: Text(
                                                      " ${habit.streak.toString()}",
                                                      style: dark
                                                          ? ViTextTheme
                                                              .darkTextTheme
                                                              .headlineSmall
                                                              ?.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: AppColors
                                                                  .lightGrey,
                                                            )
                                                          : ViTextTheme
                                                              .ligthTextTheme
                                                              .headlineSmall
                                                              ?.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: AppColors
                                                                  .black,
                                                            )),
                                                  subtitle: Text("Strike Days",
                                                      style: dark
                                                          ? ViTextTheme
                                                              .darkTextTheme
                                                              .titleLarge
                                                              ?.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              color: AppColors
                                                                  .lightGrey,
                                                            )
                                                          : ViTextTheme
                                                              .ligthTextTheme
                                                              .titleLarge
                                                              ?.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              color: AppColors
                                                                  .black,
                                                            )),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: ViSizes.lg / 1.5),
                                      ViContainer(
                                        width: double.infinity,
                                        height: 50,
                                        borderRadius: BorderRadius.circular(
                                            ViSizes.cardRadiusLg),
                                        bgColor: Theme.of(context).primaryColor,
                                        child: Center(
                                            child: Text(
                                          "Complated Task",
                                          style: ViTextTheme
                                              .darkTextTheme.titleLarge
                                              ?.copyWith(
                                            fontWeight: FontWeight.w300,
                                            color: AppColors.lightGrey,
                                          ),
                                        )),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ] else ...[
                          ViContainer(
                            bgColor: AppColors.white,
                            borderRadius:
                                BorderRadius.circular(ViSizes.cardRadiusLg * 2),
                            width: double.infinity,
                            height:
                                ViHelpersFunctions.screenHeigth(context) * 0.75,
                          ),
                        ]
                      ],
                    ),
                  );
                },
                childCount:
                    2, // 2 öğe ekliyoruz (başka öğeler ekleyebilirsiniz)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
