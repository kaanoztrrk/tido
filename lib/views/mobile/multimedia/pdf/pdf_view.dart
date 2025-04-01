import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import '../../../../common/widget/appbar/appbar.dart';

class FullScreenPdfPage extends StatelessWidget {
  final String pdfPath;
  const FullScreenPdfPage({super.key, required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ViAppBar(
        centerTitle: true,
        showBackArrow: true,
        title: Text("TiDo Pdf Viewer"),
      ),
      body: PDFView(
        filePath: pdfPath,
      ),
    );
  }
}
