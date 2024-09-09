// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart'; // Tarih formatlama için gerekli paket

import '../../../../blocs/auth_blocs/authentication_bloc/authentication_bloc.dart';
import '../../../../blocs/auth_blocs/authentication_bloc/authentication_state.dart';
import '../../../../common/widget/button/ratio_button.dart';
import '../../../../core/l10n/l10n.dart';
import '../../../../core/widget/user/profile_image.dart';
import '../../../../data/models/task_model/task_model.dart';
import '../../../../utils/Constant/colors.dart';
import '../../../../utils/Constant/sizes.dart';
import '../../../../utils/Helpers/helpers_functions.dart';
import '../../../../utils/Theme/custom_theme.dart/text_theme.dart';

class ViTaskInfoWidget extends StatelessWidget {
  const ViTaskInfoWidget({super.key, required this.task});

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        created_info(context, dark),
        dead_time(context, dark),
      ],
    );
  }

  Row dead_time(BuildContext context, bool dark) {
    // Due date formatlama
    final DateFormat formatter = DateFormat('dd MMM yyyy');
    // Ensure task.taskTime is not null
    final String dueDate = task.taskTime != null
        ? formatter.format(task.taskTime!)
        : AppLocalizations.of(context)!.no_due_time;

    return Row(
      children: [
        const ViRotioButton(
          child: Icon(Iconsax.calendar),
        ),
        const SizedBox(width: ViSizes.sm),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.due_time,
              style: dark
                  ? ViTextTheme.darkTextTheme.titleLarge
                  : ViTextTheme.ligthTextTheme.titleLarge,
            ),
            Text(
              dueDate,
              style: dark
                  ? ViTextTheme.darkTextTheme.titleLarge?.copyWith(
                      color: AppColors.secondaryText,
                      fontWeight: FontWeight.normal)
                  : ViTextTheme.ligthTextTheme.titleLarge?.copyWith(
                      color: AppColors.secondaryText,
                      fontWeight: FontWeight.normal),
            ),
          ],
        )
      ],
    );
  }

  Row created_info(BuildContext context, bool dark) {
    return Row(
      children: [
        const ViProfileImage(),
        const SizedBox(width: ViSizes.sm),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.created,
              style: dark
                  ? ViTextTheme.darkTextTheme.titleLarge
                  : ViTextTheme.ligthTextTheme.titleLarge,
            ),
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                // Ensure state.user is not null
                final userName = state.user?.displayName ??
                    AppLocalizations.of(context)!.unkownUser;
                return Text(
                  userName,
                  style: dark
                      ? ViTextTheme.darkTextTheme.titleLarge?.copyWith(
                          color: AppColors.secondaryText,
                          fontWeight: FontWeight.normal)
                      : ViTextTheme.ligthTextTheme.titleLarge?.copyWith(
                          color: AppColors.secondaryText,
                          fontWeight: FontWeight.normal),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
