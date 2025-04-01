// ignore_for_file: library_private_types_in_public_api

import 'dart:io';
import 'package:TiDo/utils/Helpers/helpers_functions.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import '../../../../utils/Constant/colors.dart';
import '../../../../utils/Constant/sizes.dart';

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
      return const Icon(Icons.insert_drive_file,
          size: 30, color: AppColors.white);
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
        return Icon(fileIcons['video'], size: 30, color: AppColors.white);
      case 'pdf':
        return Icon(fileIcons['pdf'], size: 30, color: AppColors.white);
      default:
        return Icon(fileIcons['default'], size: 30, color: AppColors.white);
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
      showDialog(
        context: context,
        builder: (context) => Dialog(
          child: InteractiveViewer(
            child: Image.file(File(widget.filePath)),
          ),
        ),
      );
    } else if (['mp4', 'mov', 'avi'].contains(fileExtension)) {
      showDialog(
        context: context,
        builder: (context) =>
            Dialog(child: VideoPlayerScreen(videoPath: widget.filePath)),
      );
    } else if (fileExtension == 'pdf') {
      showDialog(
        context: context,
        builder: (context) => Dialog(child: PDFView(filePath: widget.filePath)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openFile(context),
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

class VideoPlayerScreen extends StatefulWidget {
  final String videoPath;
  const VideoPlayerScreen({super.key, required this.videoPath});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoPath))
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller))
            : const CircularProgressIndicator(),
      ),
    );
  }
}
