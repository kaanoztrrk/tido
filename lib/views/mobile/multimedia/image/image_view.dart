import 'dart:io';
import 'package:TiDo/common/widget/appbar/appbar.dart';
import 'package:TiDo/utils/Constant/colors.dart';
import 'package:flutter/material.dart';

class FullScreenImagePage extends StatefulWidget {
  final String imagePath;
  const FullScreenImagePage({super.key, required this.imagePath});

  @override
  _FullScreenImagePageState createState() => _FullScreenImagePageState();
}

class _FullScreenImagePageState extends State<FullScreenImagePage> {
  late String _currentImagePath;

  @override
  void initState() {
    super.initState();
    _currentImagePath = widget.imagePath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ViAppBar(
        showBackArrow: true,
        centerTitle: true,
        title: const Text("TiDo Image Viewer"),
      ),
      body: Center(
        child: InteractiveViewer(
          panEnabled: true, // Allow panning
          minScale: 1.0, // Disable zoom-out beyond original size
          maxScale: 3.0, // You can adjust this based on how much zoom you want
          child: FittedBox(
            fit: BoxFit.cover, // Ensures the image will fit within the bounds
            child: Image.file(
              File(_currentImagePath),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
        ),
      ),
    );
  }
}
