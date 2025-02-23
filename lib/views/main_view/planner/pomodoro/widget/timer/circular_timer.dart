// ignore_for_file: library_private_types_in_public_api

import 'package:TiDo/utils/Constant/colors.dart';
import 'package:flutter/material.dart';

import '../../../../../../common/styles/circular_progress_painter.dart';
import '../../../../../../data/services/study_technique/pomodoro_service.dart';

class ViCircularTimer extends StatefulWidget {
  final PomodoroService pomodoroService; // Pass the service instance
  final double? strokeWidth; // Stroke width
  final Color? backgroundColor; // Background color
  final Color? progressColor; // Progress color
  final Color? outerCircleColor; // Outer circle color
  final Color? outerCircleProgressColor; // Outer circle progress color

  const ViCircularTimer({
    super.key,
    required this.pomodoroService,
    this.strokeWidth = 20.0,
    this.backgroundColor,
    this.progressColor,
    this.outerCircleColor,
    this.outerCircleProgressColor,
  });

  @override
  _ViCircularTimerState createState() => _ViCircularTimerState();
}

class _ViCircularTimerState extends State<ViCircularTimer> {
  @override
  void initState() {
    super.initState();
    widget.pomodoroService.addListener(_updateState);
  }

  @override
  void dispose() {
    widget.pomodoroService.removeListener(_updateState);
    super.dispose();
  }

  void _updateState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final remainingTime = widget.pomodoroService.currentDuration.toInt();
    final percentage =
        (remainingTime / widget.pomodoroService.selectedTime).clamp(0.0, 1.0);

    return SizedBox(
      width: 200.0,
      height: 200.0,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(200.0, 200.0),
            painter: CircularProgressPainter(
                progress: percentage,
                strokeWidth: widget.strokeWidth ?? 20,
                backgroundColor: widget.backgroundColor ?? Colors.grey,
                progressColor: widget.progressColor ?? AppColors.white,
                outerCircleColor: widget.outerCircleColor ??
                    Theme.of(context).primaryColor.withValues(alpha: 0.1),
                outerCircleProgressColor: widget.outerCircleProgressColor ??
                    Theme.of(context).primaryColor,
                innerDotFillColor: AppColors.light,
                innerDotBorderColor: Theme.of(context).primaryColor),
          ),
          Text(
            _formatTime(remainingTime),
            style: const TextStyle(
              fontSize: 48.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
