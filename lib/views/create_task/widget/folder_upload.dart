import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tido/common/widget/button/ratio_button.dart';
import 'package:tido/utils/Constant/colors.dart';
import 'package:tido/utils/Constant/sizes.dart';

import '../../../common/styles/container_style.dart';
import '../../../common/widget/task_tile/selected_files_tile.dart';
import '../../../utils/Helpers/helpers_functions.dart';
import '../../../utils/Theme/custom_theme.dart/text_theme.dart';

class ViFolderUpload extends StatefulWidget {
  final Function(List<String>) onFilesSelected;

  const ViFolderUpload({Key? key, required this.onFilesSelected})
      : super(key: key);

  @override
  _ViFolderUploadState createState() => _ViFolderUploadState();
}

class _ViFolderUploadState extends State<ViFolderUpload> {
  List<String>? _selectedFiles;
  bool _isGridView = false;

  Future<void> _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'doc', 'docx', 'pdf'],
    );

    if (result != null) {
      setState(() {
        _selectedFiles =
            result.paths.where((path) => path != null).cast<String>().toList();
      });
      widget.onFilesSelected(_selectedFiles!);
    } else {
      print("No file selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: _pickFiles,
      onLongPress: () => _showFilesBottomSheet(context),
      child: ViContainer(
        margin: const EdgeInsets.all(ViSizes.sm / 2),
        padding: const EdgeInsets.all(ViSizes.sm),
        borderRadius: BorderRadius.circular(30),
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ViRotioButton(
              bgColor: AppColors.primary,
              child: Icon(
                Iconsax.document,
                color: AppColors.white,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                _selectedFiles != null && _selectedFiles!.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(ViSizes.sm),
                        child: Text.rich(TextSpan(
                            text: "${_selectedFiles!.length}\n",
                            style: dark
                                ? ViTextTheme.darkTextTheme.headlineLarge
                                    ?.copyWith(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.bold)
                                : ViTextTheme.ligthTextTheme.headlineLarge
                                    ?.copyWith(
                                        color: AppColors.primaryText,
                                        fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: "Files attached",
                                style: dark
                                    ? ViTextTheme.darkTextTheme.titleLarge
                                        ?.copyWith(
                                            color: AppColors.secondaryText)
                                    : ViTextTheme.ligthTextTheme.titleLarge
                                        ?.copyWith(
                                            color: AppColors.secondaryText),
                              )
                            ])),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(ViSizes.sm),
                        child: Text.rich(TextSpan(
                            text: "Selected\n",
                            style: dark
                                ? ViTextTheme.darkTextTheme.headlineMedium
                                    ?.copyWith(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.bold)
                                : ViTextTheme.ligthTextTheme.headlineMedium
                                    ?.copyWith(
                                        color: AppColors.primaryText,
                                        fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: "Files",
                                style: dark
                                    ? ViTextTheme.darkTextTheme.titleLarge
                                        ?.copyWith(
                                            color: AppColors.secondaryText)
                                    : ViTextTheme.ligthTextTheme.titleLarge
                                        ?.copyWith(
                                            color: AppColors.secondaryText),
                              )
                            ])),
                      )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showFilesBottomSheet(BuildContext context) {
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
                            _isGridView ? Icons.view_list : Icons.view_module),
                        onPressed: () {
                          setState(() {
                            _isGridView = !_isGridView;
                          });
                        },
                      )
                    ],
                  ),
                  Expanded(
                    child: _selectedFiles != null && _selectedFiles!.isNotEmpty
                        ? _isGridView
                            ? GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 4.0,
                                  mainAxisSpacing: 4.0,
                                ),
                                itemCount: _selectedFiles!.length,
                                itemBuilder: (context, index) {
                                  return GridTile(
                                    child:
                                        _buildFileItem(_selectedFiles![index]),
                                  );
                                },
                              )
                            : ListView.builder(
                                itemCount: _selectedFiles!.length,
                                itemBuilder: (context, index) {
                                  return SelectedFilesTile(
                                      leading: _buildFileItem(
                                          _selectedFiles![index]),
                                      title: _selectedFiles![index]
                                          .split('/')
                                          .last);
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
