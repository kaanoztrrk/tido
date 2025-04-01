import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

class FullScreenVideoPage extends StatefulWidget {
  final String videoPath;
  const FullScreenVideoPage({super.key, required this.videoPath});

  @override
  _FullScreenVideoPageState createState() => _FullScreenVideoPageState();
}

class _FullScreenVideoPageState extends State<FullScreenVideoPage> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;
  bool _isInitialized = false; // To track initialization state

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoPath))
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true; // Update UI after initialization
        });
        _chewieController = ChewieController(
          videoPlayerController: _controller,
          autoPlay: true,
          looping: false,
          showControls: true,
          allowFullScreen: true,
          fullScreenByDefault: true,
          materialProgressColors: ChewieProgressColors(
            playedColor: Colors.white,
            handleColor: Colors.white,
            backgroundColor: Colors.grey,
          ),
        );
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("TiDo Video Viewer"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: _isInitialized
            ? Chewie(
                controller:
                    _chewieController) // Show the video player once initialized
            : const CircularProgressIndicator(), // Show loading indicator while initializing
      ),
    );
  }
}
