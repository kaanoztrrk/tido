// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:iconsax/iconsax.dart';

import '../../../common/bottom_sheet/files_bottom_sheet.dart';
import '../../../common/styles/square_container_style.dart';
import '../../../core/l10n/l10n.dart';
import '../../../utils/Constant/colors.dart';
import '../../../utils/Constant/sizes.dart';
import '../../../utils/Helpers/helpers_functions.dart';
import '../../../utils/Snackbar/snacbar_service.dart';
import '../../../utils/Theme/custom_theme.dart/text_theme.dart';

class ViFolderUpload extends StatefulWidget {
  final Function(List<String>) onFilesSelected;
  final Function()? onLongPress;
  final String? title;
  final String? subtitle;
  List<String>? selectedFiles;

  ViFolderUpload({
    super.key,
    required this.onFilesSelected,
    this.title,
    this.subtitle,
    this.onLongPress,
    this.selectedFiles,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ViFolderUploadState createState() => _ViFolderUploadState();
}

class _ViFolderUploadState extends State<ViFolderUpload> {
  Future<void> _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'doc', 'docx', 'pdf'],
    );

    if (result != null) {
      List<String> newFiles =
          result.paths.where((path) => path != null).cast<String>().toList();

      setState(() {
        widget.selectedFiles = [...?widget.selectedFiles, ...newFiles];
      });

      widget.onFilesSelected(widget.selectedFiles!);
    } else {
      ViSnackbar.showWarning(
          context, AppLocalizations.of(context)!.no_file_selected);
    }
  }

  void _showFilesBottomSheet() {
    ViUploadBottomSheet().showFilesBottomSheet(
      context,
      widget.selectedFiles,
      (updatedFiles) {
        setState(() {
          widget.selectedFiles = updatedFiles;
        });
        widget.onFilesSelected(updatedFiles);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = ViHelpersFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: _pickFiles,
      onLongPress: () {
        if (widget.onLongPress != null) {
          widget.onLongPress!();
        }
        _showFilesBottomSheet();
      },
      child: ViSquareContainer(
        icon: Iconsax.document_1,
        widget: Row(
          children: [
            if (widget.selectedFiles != null &&
                widget.selectedFiles!.isNotEmpty)
              _buildFilesCountText(isDarkMode)
            else
              _buildDefaultText(isDarkMode),
          ],
        ),
      ),
    );
  }

  Widget _buildFilesCountText(bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.all(ViSizes.sm),
      child: Text.rich(
        TextSpan(
          text: "${widget.selectedFiles!.length}\n",
          style: isDarkMode
              ? ViTextTheme.darkTextTheme.headlineLarge?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                )
              : ViTextTheme.ligthTextTheme.headlineLarge?.copyWith(
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.bold,
                ),
          children: [
            TextSpan(
              text: AppLocalizations.of(context)!.files_attached,
              style: isDarkMode
                  ? ViTextTheme.darkTextTheme.titleLarge?.copyWith(
                      color: AppColors.secondaryText,
                    )
                  : ViTextTheme.ligthTextTheme.titleLarge?.copyWith(
                      color: AppColors.secondaryText,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultText(bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.all(ViSizes.sm),
      child: Text.rich(
        TextSpan(
          text: widget.title ?? "${AppLocalizations.of(context)!.files}\n",
          style: isDarkMode
              ? ViTextTheme.darkTextTheme.headlineMedium?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                )
              : ViTextTheme.ligthTextTheme.headlineMedium?.copyWith(
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.bold,
                ),
          children: [
            TextSpan(
              text: AppLocalizations.of(context)!.selected,
              style: isDarkMode
                  ? ViTextTheme.darkTextTheme.titleLarge?.copyWith(
                      color: AppColors.secondaryText,
                    )
                  : ViTextTheme.ligthTextTheme.titleLarge?.copyWith(
                      color: AppColors.secondaryText,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
