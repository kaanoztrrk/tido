import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';

import '../../../../../blocs/home_bloc/home_bloc.dart';
import '../../../../../blocs/home_bloc/home_event.dart';
import '../../../../../common/widget/item_tile/task/task_list_tile.dart';
import '../../../../../common/widget/item_tile/task/task_swiper_tile.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../data/models/task_model/task_model.dart';
import '../../../../../data/services/google_ads_service.dart';
import '../../../../../utils/bottom_sheet/bottom_sheet.dart';

class HomeList extends StatelessWidget {
  final List<TaskModel> tasksToShow;
  final List<TaskModel> allTasksList;

  const HomeList({
    Key? key,
    required this.tasksToShow,
    required this.allTasksList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: allTasksList.length + 1, // Banner için +1 ekledik
      itemBuilder: (context, index) {
        if (index == 0) {
          // Listenin başına reklam ekleme
          return SizedBox(
            height: 80, // Reklamın yüksekliği
            child: AdWidget(
              ad: GoogleAdsService().loadBannerAd()!,
            ),
          );
        }
        final task =
            tasksToShow[index - 1]; // Banner'ı hesaba katarak index kaydırıldı
        return ViTaskListTile(
          task: task,
          onTap: () {
            context.push(ViRoutes.task_detail_view, extra: task);
          },
          optionTap: () => ViBottomSheet.showOptionBottomSheet(
            context,
            onEdit: () {
              context.push(ViRoutes.task_edit_view, extra: task);
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
          ),
          title: task.title,
          files: task.files!.length.toString(),
          dueTime: task.taskTime != null
              ? Text(
                  "${task.taskTime!.day} ${DateFormat('MMM').format(task.taskTime!)} ${task.taskTime!.year}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )
              : null,
          description: task.description.toString(),
        );
      },
    );
  }
}
