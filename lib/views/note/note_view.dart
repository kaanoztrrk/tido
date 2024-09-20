import 'package:TiDo/common/widget/appbar/home_appbar.dart';
import 'package:TiDo/views/main_view/home/widget/note_header.dart';
import 'package:flutter/material.dart';

import '../../utils/Constant/sizes.dart';
import '../main_view/home/widget/home_header.dart';

class NoteView extends StatelessWidget {
  const NoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      //* Appbar
      appBar: ViHomeAppBar(
        height: ViSizes.appBarHeigth * 2,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: ViSizes.defaultSpace),
        child: Column(
          children: [
            NoteHeader(),
          ],
        ),
      ),
    );
  }
}
