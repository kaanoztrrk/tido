import 'package:flutter/material.dart';
import 'dart:io';
import '../../utils/Constant/colors.dart';
import '../../utils/Constant/sizes.dart';
import '../../utils/Theme/custom_theme.dart/text_theme.dart';
import '../widget/task_tile/selected_files_tile.dart';

class ViUploadBottomSheet {
  void showFilesBottomSheet(
      BuildContext context, bool isGridView, List<String>? selectedFiles) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.all(ViSizes.sm),
              height: 300,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Selected Files",
                        style: ViTextTheme.ligthTextTheme.titleLarge,
                      ),
                      IconButton(
                        icon: Icon(
                            isGridView ? Icons.view_list : Icons.view_module),
                        onPressed: () {
                          setState(() {
                            isGridView = !isGridView;
                          });
                        },
                      )
                    ],
                  ),
                  Expanded(
                    child: selectedFiles != null && selectedFiles.isNotEmpty
                        ? isGridView
                            ? GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 4.0,
                                  mainAxisSpacing: 4.0,
                                ),
                                itemCount: selectedFiles.length,
                                itemBuilder: (context, index) {
                                  return GridTile(
                                    child: _buildFileItem(selectedFiles[index]),
                                  );
                                },
                              )
                            : ListView.builder(
                                itemCount: selectedFiles.length,
                                itemBuilder: (context, index) {
                                  return SelectedFilesTile(
                                      leading:
                                          _buildFileItem(selectedFiles[index]),
                                      title:
                                          selectedFiles[index].split('/').last);
                                },
                              )
                        : const Center(child: Text("No files selected")),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFileItem(String filePath) {
    final fileName = filePath.split('/').last;
    final fileExtension = fileName.split('.').last.toLowerCase();

    if (['jpg', 'jpeg', 'png'].contains(fileExtension)) {
      return Image.file(
        File(filePath),
        fit: BoxFit.cover,
      );
    } else {
      IconData iconData;
      switch (fileExtension) {
        case 'pdf':
          iconData = Icons.picture_as_pdf;
          break;
        case 'doc':
        case 'docx':
          iconData = Icons.description;
          break;
        default:
          iconData = Icons.insert_drive_file;
      }
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            size: 30,
            color: AppColors.white,
          ),
        ],
      );
    }
  }
}
