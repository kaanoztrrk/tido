import 'dart:ui';
import '../../../core/gen/assets.gen.dart';

class LanguageModel {
  final Locale locale;
  final AssetGenImage image;
  final String text;

  const LanguageModel({
    required this.locale,
    required this.image,
    required this.text,
  });

  static var english = LanguageModel(
    locale: const Locale('en', 'US'),
    image: Assets.image.language.unitedKingdom,
    text: 'English',
  );

  static var turkiye = LanguageModel(
    locale: const Locale('tr', 'TR'),
    image: Assets.image.language.turkiye,
    text: 'Turkish',
  );

  static List<LanguageModel> get values => [english, turkiye];
}
