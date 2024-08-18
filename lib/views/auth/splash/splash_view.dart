import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tido/utils/Constant/image_strings.dart';
import 'package:tido/utils/Helpers/helpers_functions.dart';
import 'package:tido/core/routes/routes.dart';
import 'package:tido/data/services/shared_preferences_service.dart';
import 'package:tido/utils/Constant/app_constants.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      final isFirstTime = await _isFirstTimeOpening();
      if (isFirstTime) {
        await _setFirstTimeOpening();
        context
            .go(ViRoutes.welcome_view); // İlk açılışta WelcomeView'e yönlendir
      } else {
        context.go(ViRoutes.main); // Zaten açılmışsa MainNavigator'a yönlendir
      }
    }
  }

  Future<bool> _isFirstTimeOpening() async {
    final isFirstTime = await SharedPreferencesService.instance
        .getBool(APPContants.isFirstTimeOpening);
    return isFirstTime ?? true;
  }

  Future<void> _setFirstTimeOpening() async {
    await SharedPreferencesService.instance
        .setBool(APPContants.isFirstTimeOpening, false);
  }

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    return Scaffold(
      body: Center(
        child: Image(
          image: AssetImage(
            dark ? ViImages.logo_ligth : ViImages.logo_dark,
          ),
        ),
      ),
    );
  }
}
