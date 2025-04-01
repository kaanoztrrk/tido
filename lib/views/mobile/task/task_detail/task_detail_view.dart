import 'package:TiDo/blocs/auth_blocs/authentication_bloc/authentication_bloc.dart';
import 'package:TiDo/common/widget/appbar/appbar.dart';
import 'package:TiDo/utils/Helpers/helpers_functions.dart';
import 'package:TiDo/views/mobile/task/task_detail/widget/task_content.dart';
import 'package:TiDo/views/mobile/task/task_detail/widget/task_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../blocs/auth_blocs/authentication_bloc/authentication_state.dart';
import '../../../../blocs/theme_bloc/theme_bloc.dart';
import '../../../../blocs/theme_bloc/theme_state.dart';
import '../../../../core/l10n/l10n.dart';
import '../../../../core/locator/locator.dart';
import '../../../../core/routes/routes.dart';
import '../../../../data/models/task_model/task_model.dart';
import '../../../../utils/Constant/sizes.dart';
import '../../../../utils/Theme/custom_theme.dart/text_theme.dart';

class TaskDetailView extends StatelessWidget {
  final TaskModel task;

  const TaskDetailView({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);

    return BlocProvider.value(
      value: getIt<ThemeBloc>(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: ViAppBar(
              appBarBackgroundColor: Colors.transparent,
              showBackArrow: true,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.share_outlined),
                ),
                IconButton(
                  onPressed: () {
                    context.push(ViRoutes.task_edit_view, extra: task);
                  },
                  icon: const Icon(Iconsax.edit_2),
                ),
              ],
            ),
            body: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(ViSizes.defaultSpace),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: ViSizes.spaceBtwItems),
                      //* title
                      LayoutBuilder(
                        builder: (context, constraints) {
                          double fontSize = constraints.maxWidth > 300
                              ? 24
                              : 18; // Genişliğe göre font boyutunu ayarla.
                          return Text(
                            task.title,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: dark
                                ? ViTextTheme.darkTextTheme.headlineLarge
                                    ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: fontSize, // Dinamik font boyutu
                                  )
                                : ViTextTheme.ligthTextTheme.headlineLarge
                                    ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: fontSize, // Dinamik font boyutu
                                  ),
                          );
                        },
                      ),
                      SizedBox(height: ViSizes.spaceBtwItems),
                      BlocBuilder<AuthenticationBloc, AuthenticationState>(
                        builder: (context, state) {
                          // Ensure state.user is not null
                          final userName = state.user?.displayName ??
                              AppLocalizations.of(context)!.unkownUser;

                          // Handle null taskTime
                          final endDate = task.taskTime != null
                              ? ViHelpersFunctions.getFormattedDate(
                                  task.taskTime!)
                              : "-";
                          final time = task.taskTime != null
                              ? ViHelpersFunctions.getFormattedTime(
                                  task.taskTime!)
                              : "-";

                          return TaskInfoWidget(
                            creator: userName,
                            endDate: endDate,
                            time: time,
                            priority: task.priority,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                TaskContentWidget(task: task),
              ],
            ),
          );
        },
      ),
    );
  }
}
