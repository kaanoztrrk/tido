import 'package:TiDo/data/models/task_model/task_model.dart';
import 'package:TiDo/utils/Constant/sizes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../common/widget/item_tile/task/task_detail_files.dart';
import '../../../../../core/routes/routes.dart';

class AttachmentWidget extends StatelessWidget {
  const AttachmentWidget({super.key, required this.files, required this.task});

  final List<String> files;
  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Add new box with plus button at the beginning of the list
        SizedBox(
          height: 75,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: files.length + 1, // Adding 1 for the new plus button
            itemBuilder: (context, index) {
              if (index == 0) {
                return GestureDetector(
                  onTap: () =>
                      context.push(ViRoutes.task_edit_view, extra: task),
                  child: Container(
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Icon(Icons.add,
                          size: ViSizes.iconMd, color: Colors.white),
                    ),
                  ),
                );
              }
              // Return file items starting from index 1
              return SelectedFilesTile(
                filePath: files[index - 1],
              );
            },
          ),
        ),
      ],
    );
  }
}
