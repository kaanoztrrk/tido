import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  //* App Basic Colors
  static const Color primary = Color(0xffFE6E68);
  static const Color secondary = Color(0xffFE9F69);

  static const Color thistle = Color(0xff023047);
  static const Color thistleDark = Color(0xff219ebc); // Uyumlu geçiş rengi

  static const Color fairyTile = Color(0xffFFC8DD);
  static const Color fairyTileDark = Color(0xfff6a0b6); // Uyumlu geçiş rengi

  static const Color carnotionPink = Color(0xffFFAFCC);
  static const Color carnotionPinkDark =
      Color(0xfff99acb); // Uyumlu geçiş rengi

  static const Color uranianBlue = Color(0xffBDE0FE);
  static const Color uranianBlueDark = Color(0xff8fc4e3); // Uyumlu geçiş rengi

  static const Color ligthSkyBlue = Color(0xffA2D2FF);
  static const Color ligthSkyBlueDark = Color(0xff7ab8d7); // Uyumlu geçiş rengi

  //* Texts Color
  static const Color primaryText = Color(0xff101214);
  static const Color secondaryText = Color(0xff6D6D76);

  //* TextField Background color
  static const Color textfieldBg = Color(0xffE4E4E4);

  //* Background Colors
  static const Color light = Color(0xffF3F3F3);
  static const Color dark = Color(0xff161616);

  //* Gradient Colors
  static const Gradient primaryGradientButton = LinearGradient(
    begin: Alignment(0.0, 0.0),
    end: Alignment(0.707, -0.707),
    colors: [
      AppColors.primary,
      AppColors.secondary,
    ],
  );

  static const Gradient thistleGradientButton = RadialGradient(
    center: Alignment.center,
    radius: 0.8,
    colors: [
      AppColors.thistle,
      AppColors.thistleDark,
    ],
    stops: [
      0.0,
      1.0
    ], // Optionally specify stops to control the gradient transition
  );

  static const Gradient fairyTileGradientButton = LinearGradient(
    begin: Alignment(0.0, 0.0),
    end: Alignment(0.707, -0.707),
    colors: [
      AppColors.fairyTile,
      AppColors.fairyTileDark,
    ],
  );
  static const Gradient carnotionPinkGradientButton = LinearGradient(
    begin: Alignment(0.0, 0.0),
    end: Alignment(0.707, -0.707),
    colors: [
      AppColors.carnotionPink,
      AppColors.carnotionPinkDark,
    ],
  );
  static const Gradient uranianBlueGradientButton = LinearGradient(
    begin: Alignment(0.0, 0.0),
    end: Alignment(0.707, -0.707),
    colors: [
      AppColors.uranianBlue,
      AppColors.uranianBlueDark,
    ],
  );
  static const Gradient ligthSkyBlueGradientButton = LinearGradient(
    begin: Alignment(0.0, 0.0),
    end: Alignment(0.707, -0.707),
    colors: [
      AppColors.ligthSkyBlue,
      AppColors.ligthSkyBlueDark,
    ],
  );

  //* Error and Validation Colors
  static const Color error = Color(0xffd43f2f);
  static const Color success = Color(0xff388e3c);
  static const Color warning = Color(0xfff57c00);
  static const Color info = Color(0xff1976d2);

  //* Bottom Navigator Colors
  static const Color bottomNavigatorBackground = Color(0xffECECEC);
  static const Color bottomNavigatorItemDefaultBg = Color(0xffE6E6E6);
  static const Color bottomNavigatorItemActiveBg = Color(0xffD4D5D7);

  //* Neutral Shades
  static const Color black = Color(0xff232323);
  static const Color darkerGrey = Color(0xff4f4f4f);
  static const Color darkGrey = Color(0xffD4D5D7);
  static const Color darkgrey = Color(0xff939393);
  static const Color grey = Color(0xffe0e0e0);
  static const Color softGrey = Color(0xfff4f4f4);
  static const Color lightGrey = Color(0xfff9f9f9);
  static const Color white = Color(0xffffffff);
}
