import 'package:flutter/material.dart';
import 'package:tido/utils/Theme/theme.dart';

import 'utils/Constant/text_strings.dart';
import 'core/routes/routes_manager.dart';

class TIDO extends StatelessWidget {
  const TIDO({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: ViTexts().appTitle,
      theme: ViAppTheme.ligthTheme,
      darkTheme: ViAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}
