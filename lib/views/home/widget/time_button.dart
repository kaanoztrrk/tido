import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tido/common/widget/button/ratio_button.dart';
import 'package:tido/core/routes/routes.dart';
import 'package:tido/utils/Constant/colors.dart';
import 'package:tido/utils/Helpers/helpers_functions.dart';

import '../../../blocs/home_bloc/home_bloc.dart';
import '../../../blocs/home_bloc/home_state.dart';
import '../../../utils/Theme/custom_theme.dart/text_theme.dart';

class ViTimeButton extends StatelessWidget {
  final VoidCallback? createTaskTap;
  final VoidCallback? notificationTaskTap;
  final String? timeText;
  final IconData icon;

  const ViTimeButton({
    super.key,
    this.createTaskTap,
    this.timeText,
    required this.icon,
    this.notificationTaskTap,
  });

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(50),
          ),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Row(
            children: [
              GestureDetector(
                onTap: createTaskTap,
                child: ViRotioButton(
                  child: Icon(icon),
                ),
              ),
              if (state.remainingTime.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      if (state.currentTask != null) {
                        context.push(ViRoutes.task_detail_view,
                            extra: state.currentTask);
                      }
                    },
                    child: Text(
                      state.remainingTime,
                      style: dark
                          ? ViTextTheme.ligthTextTheme.titleLarge
                          : ViTextTheme.darkTextTheme.titleLarge,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
