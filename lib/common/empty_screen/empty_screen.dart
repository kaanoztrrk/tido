import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../data/services/google_ads_service.dart';
import '../../utils/Constant/colors.dart';
import '../../utils/Helpers/helpers_functions.dart';
import '../../utils/Theme/custom_theme.dart/text_theme.dart';

class ViEmptyScreen extends StatefulWidget {
  const ViEmptyScreen({
    super.key,
    required this.title,
    required this.subTitle,
    required this.image,
    this.size,
    this.color,
    this.showBanner = true,
    this.bannerHeight = 90,
    this.bannerColor = AppColors.grey,
    this.bannerAlignment = Alignment.bottomCenter,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  final String image;
  final String title;
  final String subTitle;
  final double? size;
  final Color? color;
  final bool showBanner;
  final double bannerHeight;
  final Color bannerColor;
  final AlignmentGeometry bannerAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  _ViEmptyScreenState createState() => _ViEmptyScreenState();
}

class _ViEmptyScreenState extends State<ViEmptyScreen> {
  final GoogleAdsService _adsService = GetIt.I<GoogleAdsService>();

  @override
  void initState() {
    super.initState();
    if (widget.showBanner) {
      _adsService.loadBannerAd();
    }
  }

  @override
  void dispose() {
    _adsService.disposeBannerAd();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    return Stack(
      children: [
        // İçerik kısmı
        SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: widget.mainAxisAlignment,
            crossAxisAlignment: widget.crossAxisAlignment,
            children: [
              Image(
                fit: BoxFit.cover,
                image: AssetImage(widget.image),
                height: widget.size,
                width: widget.size,
                color: widget.color,
              ),
              Text(
                widget.title,
                style: dark
                    ? ViTextTheme.darkTextTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      )
                    : ViTextTheme.ligthTextTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
              ),
              Text(
                widget.subTitle,
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
        // Banner kısmı
        if (widget.showBanner)
          Align(
            alignment: widget.bannerAlignment,
            child: _adsService.bannerAd != null
                ? SizedBox(
                    width: double.infinity,
                    height: _adsService.bannerAd!.size.height.toDouble(),
                    child: AdWidget(ad: _adsService.bannerAd!),
                  )
                : Container(),
          ),
      ],
    );
  }
}
