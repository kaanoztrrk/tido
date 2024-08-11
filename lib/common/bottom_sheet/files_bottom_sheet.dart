import 'package:flutter/material.dart';
import 'dart:io';
import '../../utils/Constant/colors.dart';
import '../../utils/Constant/sizes.dart';
import '../../utils/Theme/custom_theme.dart/text_theme.dart';
import '../widget/task_tile/selected_files_tile.dart';

class ViUploadBottomSheet {
  void showFilesBottomSheet(
    BuildContext context,
    List<String>? initialFiles,
  ) {
    List<String> selectedFiles =
        initialFiles != null ? List.from(initialFiles) : [];
    Set<String> selectedItems = {}; // Seçili dosyalar için bir set

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.all(ViSizes.sm),
              height: 400, // Yüksekliği artırdık çünkü silme butonları eklendi
              child: Column(
                children: [
                  Expanded(
                    child: selectedFiles.isNotEmpty
                        ? ListView.builder(
                            itemCount: selectedFiles.length,
                            itemBuilder: (context, index) {
                              return SelectedFilesTile(
                                leading: _buildFileItem(selectedFiles[index]),
                                title: selectedFiles[index].split('/').last,
                                isSelected: selectedItems
                                    .contains(selectedFiles[index]),
                                onSelected: (isSelected) {
                                  setState(() {
                                    if (isSelected) {
                                      selectedItems.add(selectedFiles[index]);
                                    } else {
                                      selectedItems
                                          .remove(selectedFiles[index]);
                                    }
                                  });
                                },
                              );
                            },
                          )
                        : const Center(child: Text("No files selected")),
                  ),
                  if (selectedItems
                      .isNotEmpty) // Silme butonunu sadece dosya seçildiyse göster
                    Padding(
                      padding: const EdgeInsets.all(ViSizes.sm),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedFiles.removeWhere(
                                (file) => selectedItems.contains(file));
                            selectedItems.clear();
                          });
                        },
                        child: Text('Delete Selected Files'),
                      ),
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
