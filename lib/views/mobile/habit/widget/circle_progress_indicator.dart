// ignore_for_file: library_private_types_in_public_api

import 'package:TiDo/utils/Constant/colors.dart';
import 'package:flutter/material.dart';

import '../../../../../../../common/styles/circular_progress_painter.dart';

class ViCircularProgress extends StatelessWidget {
  final double progress; // Zorunlu: Yüzdeyi temsil eden değer (0.0 - 1.0 arası)
  final double? size; // Opsiyonel: Boyut, default 200.0

  const ViCircularProgress({
    super.key,
    required this.progress, // Zorunlu parametre
    this.size = 200.0, // Varsayılan boyut 200.0
  });

  @override
  Widget build(BuildContext context) {
    // Yazı boyutunu, size parametresiyle orantılı olarak ayarlıyoruz
    double textSize =
        size != null ? size! * 0.24 : 48.0; // Boyutun %24'ü kadar yazı boyutu

    return SizedBox(
      width: size ?? 200.0, // Boyut, opsiyonel
      height: size ?? 200.0, // Boyut, opsiyonel
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size ?? 200.0, size ?? 200.0),
            painter: CircularProgressPainter(
              progress: progress, // Zorunlu parametre
              strokeWidth: 20.0,
              backgroundColor: Colors.grey,
              progressColor: Colors.transparent,
              outerCircleColor:
                  Theme.of(context).primaryColor.withValues(alpha: 0.1),
              outerCircleProgressColor: Theme.of(context).primaryColor,
              innerDotFillColor: AppColors.light,
              innerDotBorderColor: Theme.of(context).primaryColor,
            ),
          ),
          Text(
            (progress * 100).toStringAsFixed(0) + '%', // Yüzdeyi göster
            style: TextStyle(
              fontSize: textSize, // Dinamik yazı boyutu
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
