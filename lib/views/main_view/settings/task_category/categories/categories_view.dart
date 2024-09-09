import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../blocs/home_bloc/home_bloc.dart';
import '../../../../../blocs/home_bloc/home_state.dart';
import '../../../../common/empty_screen/empty_screen.dart';
import '../../../../../common/styles/container_style.dart';
import '../../../../../common/widget/appbar/appbar.dart';
import '../../../../../core/l10n/l10n.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../utils/Constant/image_strings.dart';
import '../../../../../utils/Constant/sizes.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ViAppBar(
        showBackArrow: true,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.categories,
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          // Tüm etiketleri toplamak için bir set oluşturun
          Set<String> allLabels = {};
          for (var task in state.allTasksList) {
            allLabels.addAll(task.labels as Iterable<String>);
          }
          return allLabels.isEmpty
              ? ViEmptyScreen(
                  image: ViImages.empty_screen_image_1,
                  title: AppLocalizations.of(context)!.no_tasks_found,
                  subTitle:
                      AppLocalizations.of(context)!.no_tasks_found_subTitle,
                )
              : ListView.builder(
                  itemCount: allLabels.length,
                  itemBuilder: (context, index) {
                    // Set'ten listeye dönüştürme
                    List<String> labelsList = allLabels.toList();
                    final selectedLabel = labelsList[index];

                    // Filtrelenmiş görevleri almak
                    final tasksWithLabel = state.allTasksList
                        .where((task) => task.labels!.contains(selectedLabel))
                        .toList();

                    return ViContainer(
                      margin: const EdgeInsets.symmetric(
                          horizontal: ViSizes.defaultSpace,
                          vertical: ViSizes.defaultSpace / 2),
                      borderRadius: BorderRadius.circular(20),
                      child: ListTile(
                        onTap: () {
                          if (tasksWithLabel.isNotEmpty) {
                            // Assuming you want to navigate to the first task with the selected label
                            final taskToNavigate = tasksWithLabel.first;
                            context.push(
                              ViRoutes.task_detail_view,
                              extra: taskToNavigate,
                            );
                          } else {
                            // Handle case where there are no tasks with the selected label
                            // For example, show a Snackbar or a dialog
                          }
                        },
                        title: Text(selectedLabel),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
