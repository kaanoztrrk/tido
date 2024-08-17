import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tido/blocs/theme_bloc/theme_bloc.dart';
import 'package:tido/common/styles/container_style.dart';
import 'package:tido/core/locator/locator.dart';
import 'package:tido/core/routes/routes.dart';
import 'package:tido/utils/Constant/colors.dart';
import 'package:tido/utils/Constant/sizes.dart';
import '../../../blocs/theme_bloc/theme_state.dart';
import '../../../data/models/task_model/task_model.dart';
import '../../../utils/Helpers/helpers_functions.dart';
import '../../../utils/Theme/custom_theme.dart/text_theme.dart';

class CalenderTaskTile extends StatelessWidget {
  const CalenderTaskTile(
      {super.key,
      this.dateText,
      this.title,
      this.timerText,
      required this.task});

  final String? dateText;
  final String? title;
  final String? timerText;
  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    return BlocProvider.value(
      value: getIt<ThemeBloc>(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return ViContainer(
            onTap: () => context.push(ViRoutes.task_detail_view, extra: task),
            bgColor: Theme.of(context).primaryColor,
            margin: const EdgeInsets.all(ViSizes.md),
            padding: const EdgeInsets.symmetric(
                horizontal: ViSizes.md, vertical: ViSizes.sm),
            borderRadius: BorderRadius.circular(ViSizes.borderRadiusLg * 2),
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: ViSizes.sm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      dateText ?? "",
                      style: dark
                          ? ViTextTheme.ligthTextTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.black)
                          : ViTextTheme.darkTextTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.white),
                    ),
                    Row(
                      children: [
                        Text(
                          "Details",
                          style: dark
                              ? ViTextTheme.ligthTextTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.softGrey)
                              : ViTextTheme.darkTextTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.softGrey),
                        ),
                        const Icon(Icons.arrow_right,
                            color: AppColors.softGrey),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: ViSizes.md),
                  child: Text(
                    title ?? "",
                    style: dark
                        ? ViTextTheme.ligthTextTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w600, color: AppColors.black)
                        : ViTextTheme.darkTextTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.white),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                ViContainer(
                  borderRadius:
                      BorderRadius.circular(ViSizes.borderRadiusLg * 2),
                  height: 60,
                  bgColor: AppColors.lightGrey.withOpacity(0.7),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: ViSizes.md),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Iconsax.timer_1,
                          color: dark ? AppColors.dark : AppColors.white,
                        ),
                        Text(
                          timerText ?? "",
                          style: dark
                              ? ViTextTheme.ligthTextTheme.titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w600)
                              : ViTextTheme.darkTextTheme.titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
