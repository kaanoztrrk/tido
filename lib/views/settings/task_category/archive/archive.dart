import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tido/common/styles/container_style.dart';
import 'package:tido/common/widget/appbar/appbar.dart';
import 'package:tido/utils/Constant/sizes.dart';
import '../../../../blocs/home_bloc/home_bloc.dart';
import '../../../../blocs/home_bloc/home_event.dart';
import '../../../../blocs/home_bloc/home_state.dart';
import '../../../../common/bottom_sheet/task_option_bottom_sheet.dart';
import '../../../../common/empty_screen/empty_screen.dart';
import '../../../../core/l10n/l10n.dart';
import '../../../../core/routes/routes.dart';
import '../../../../data/models/task_model/task_model.dart';
import '../../../../utils/Constant/image_strings.dart';

class ArchiveView extends StatelessWidget {
  const ArchiveView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ViAppBar(
          showBackArrow: true,
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.archive,
          ),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            List<TaskModel> tasksToShow = state.allTasksList;
            return tasksToShow.isEmpty
                ? ViEmptyScreen(
                    image: ViImages.empty_screen_image_1,
                    title: AppLocalizations.of(context)!.no_tasks_found,
                    subTitle:
                        AppLocalizations.of(context)!.no_tasks_found_subTitle,
                  )
                : ListView.builder(
                    itemCount: tasksToShow.length,
                    itemBuilder: (context, index) {
                      return ViContainer(
                        margin: const EdgeInsets.all(ViSizes.defaultSpace / 2),
                        borderRadius: BorderRadius.circular(20),
                        child: ListTile(
                          onTap: () {
                            final task = tasksToShow[index];
                            return ViOptionBottomSheet().showOptionBottomSheet(
                              context,
                              onEdit: () {
                                context.push(ViRoutes.task_edit_view,
                                    extra: task);
                              },
                              onDelete: () {
                                BlocProvider.of<HomeBloc>(context)
                                    .add(DeleteToDoEvent(task: task));
                                context.pop();
                              },
                              onMarkAsComplete: () {
                                BlocProvider.of<HomeBloc>(context).add(
                                  ChangeCheckBoxEvent(
                                    isChecked: !task.isChecked,
                                    task: task,
                                  ),
                                );
                              },
                            );
                          },
                          title: Text(tasksToShow[index].title),
                        ),
                      );
                    },
                  );
          },
        ));
  }
}
