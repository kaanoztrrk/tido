import 'package:flutter/material.dart';
import '../../utils/Constant/colors.dart';
import '../../utils/Helpers/helpers_functions.dart';
import '../../utils/Theme/custom_theme.dart/text_theme.dart';

class ViEmptyScreen extends StatelessWidget {
  const ViEmptyScreen({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.image,
    this.size,
    this.color,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
  }) : super(key: key);

  final String image;
  final String title;
  final String subTitle;
  final double? size;
  final Color? color;

  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    return Stack(
      children: [
        // İçerik kısmı
        SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
            crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
            children: [
              Image(
                fit: BoxFit.cover,
                image: AssetImage(image),
                height: size,
                width: size,
                color: color,
              ),
              Text(
                title,
                style: dark
                    ? ViTextTheme.darkTextTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      )
                    : ViTextTheme.ligthTextTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
              ),
              Text(
                subTitle,
                textAlign: TextAlign.center,
                style: dark
                    ? ViTextTheme.darkTextTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.normal)
                    : ViTextTheme.ligthTextTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
