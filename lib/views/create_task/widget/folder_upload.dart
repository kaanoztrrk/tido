// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tido/common/styles/square_container_style.dart';
import 'package:tido/utils/Constant/colors.dart';
import 'package:tido/utils/Constant/sizes.dart';
import 'package:tido/utils/Snackbar/snacbar_service.dart';

import '../../../common/bottom_sheet/files_bottom_sheet.dart';
import '../../../utils/Helpers/helpers_functions.dart';
import '../../../utils/Theme/custom_theme.dart/text_theme.dart';

class ViFolderUpload extends StatefulWidget {
  final Function(List<String>) onFilesSelected;

  const ViFolderUpload({super.key, required this.onFilesSelected});

  @override
  _ViFolderUploadState createState() => _ViFolderUploadState();
}

class _ViFolderUploadState extends State<ViFolderUpload> {
  List<String>? _selectedFiles;
  final ViUploadBottomSheet _bottomSheet = ViUploadBottomSheet();
  final bool _isGridView = false;

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
      ViSnackbar.showWarning(context, "No file selected");
    }
  }

  void _showFilesBottomSheet(BuildContext context) {
    _bottomSheet.showFilesBottomSheet(context, _isGridView, _selectedFiles);
  }

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    return GestureDetector(
        onTap: _pickFiles,
        onLongPress: () => _showFilesBottomSheet(context),
        child: ViSquareContainer(
          icon: Iconsax.document5,
          widget: Row(
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
                                      ?.copyWith(color: AppColors.secondaryText)
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
                                      ?.copyWith(color: AppColors.secondaryText)
                                  : ViTextTheme.ligthTextTheme.titleLarge
                                      ?.copyWith(
                                          color: AppColors.secondaryText),
                            )
                          ])),
                    )
            ],
          ),
        ));
  }
}
