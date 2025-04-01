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

  static var espanol = LanguageModel(
    locale: const Locale('es', 'ES'),
    image: Assets
        .image.language.spain, // İspanya bayrağını temsil ettiğini varsayalım
    text: 'Spanish',
  );

  static var france = LanguageModel(
    locale: const Locale('fr', 'FR'),
    image: Assets
        .image.language.france, // Fransa bayrağını temsil ettiğini varsayalım
    text: 'French',
  );

  static var italiano = LanguageModel(
    locale: const Locale('it', 'IT'),
    image: Assets
        .image.language.italy, // İtalya bayrağını temsil ettiğini varsayalım
    text: 'Italian',
  );

  static var japanese = LanguageModel(
    locale: const Locale('ja', 'JP'),
    image: Assets
        .image.language.japan, // Japonya bayrağını temsil ettiğini varsayalım
    text: 'Japanese',
  );

  static var chinese = LanguageModel(
    locale: const Locale('zh', 'CN'),
    image:
        Assets.image.language.china, // Çin bayrağını temsil ettiğini varsayalım
    text: 'Chinese',
  );

  static List<LanguageModel> get values => [
        english,
        turkiye,
        espanol,
        france,
        italiano,
      ];
}
