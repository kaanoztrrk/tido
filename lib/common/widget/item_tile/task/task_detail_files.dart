// ignore_for_file: library_private_types_in_public_api

import 'dart:io';
import 'package:TiDo/common/widget/appbar/appbar.dart';
import 'package:TiDo/utils/Helpers/helpers_functions.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import '../../../../utils/Constant/colors.dart';
import '../../../../utils/Constant/sizes.dart';
import '../../../../views/mobile/multimedia/image/image_view.dart';
import '../../../../views/mobile/multimedia/pdf/pdf_view.dart';
import '../../../../views/mobile/multimedia/video/video_view.dart';

class SelectedFilesTile extends StatefulWidget {
  const SelectedFilesTile({
    super.key,
    this.filePath = '',
    this.title,
    this.isSelected = false,
    this.onSelected,
    this.enableLongPress = false,
  });

  final String filePath;
  final String? title;
  final bool isSelected;
  final void Function(bool)? onSelected;
  final bool enableLongPress;

  @override
  _SelectedFilesTileState createState() => _SelectedFilesTileState();
}

class _SelectedFilesTileState extends State<SelectedFilesTile> {
  late bool _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.isSelected;
  }

  // Optimized method to handle file icons or image, pdf, video
  Widget _buildFileItem(String filePath) {
    if (filePath.isEmpty) {
      return Icon(Icons.insert_drive_file,
          size: 30, color: Theme.of(context).primaryColor);
    }

    final fileExtension = _getFileExtension(filePath);

    final fileIcons = {
      'image': Icons.image,
      'video': Icons.videocam,
      'pdf': Icons.picture_as_pdf,
      'default': Icons.insert_drive_file,
    };
    switch (fileExtension) {
      case 'jpg':
      case 'jpeg':
      case 'png':
        return Image.file(File(filePath), fit: BoxFit.cover);
      case 'mp4':
      case 'mov':
      case 'avi':
        return Icon(fileIcons['video'],
            size: 30, color: Theme.of(context).primaryColor);
      case 'pdf':
        return Icon(fileIcons['pdf'],
            size: 30, color: Theme.of(context).primaryColor);
      default:
        return Icon(fileIcons['default'],
            size: 30, color: Theme.of(context).primaryColor);
    }
  }

  String _getFileExtension(String filePath) {
    final fileName = filePath.split('/').last;
    return fileName.split('.').last.toLowerCase();
  }

  void _openFile(BuildContext context) {
    if (widget.filePath.isEmpty) return;

    final fileExtension = _getFileExtension(widget.filePath);

    if (['jpg', 'jpeg', 'png'].contains(fileExtension)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FullScreenImagePage(imagePath: widget.filePath),
        ),
      );
    } else if (['mp4', 'mov', 'avi'].contains(fileExtension)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FullScreenVideoPage(videoPath: widget.filePath),
        ),
      );
    } else if (fileExtension == 'pdf') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FullScreenPdfPage(pdfPath: widget.filePath),
        ),
      );
    }
  }

  // New onTap function to print file format
  void _onTapFile(BuildContext context) {
    final fileExtension = _getFileExtension(widget.filePath);
    String formatMessage = '';

    switch (fileExtension) {
      case 'jpg':
      case 'jpeg':
      case 'png':
        formatMessage = 'This is an image file.';
        break;
      case 'mp4':
      case 'mov':
      case 'avi':
        formatMessage = 'This is a video file.';
        break;
      case 'pdf':
        formatMessage = 'This is a PDF file.';
        break;
      default:
        formatMessage = 'This is an unknown file type.';
    }

    // Print the format message
    print(formatMessage);

    // Call the original _openFile function
    _openFile(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTapFile(context), // Using new _onTapFile function
      onLongPress: widget.enableLongPress
          ? () {
              setState(() {
                _isSelected = !_isSelected;
              });
              widget.onSelected?.call(_isSelected);
            }
          : null,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: ViSizes.sm),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: _isSelected
              ? Border.all(width: 3, color: Theme.of(context).primaryColor)
              : null,
          color: Colors.grey[200],
        ),
        height: ViHelpersFunctions.screenHeigth(context),
        width: ViHelpersFunctions.screenWidth(context) / 5,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              Positioned.fill(child: _buildFileItem(widget.filePath)),
              if (widget.title != null)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    color: Colors.black54,
                    child: Text(
                      widget.title!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
