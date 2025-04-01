// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../data/services/google_ads_service.dart';

class AdMobBanner extends StatefulWidget {
  final double height;
  final Color backgroundColor;

  const AdMobBanner({
    super.key,
    this.height = 90,
    this.backgroundColor = Colors.grey,
  });

  @override
  _AdMobBannerState createState() => _AdMobBannerState();
}

class _AdMobBannerState extends State<AdMobBanner> {
  final GoogleAdsService _adsService = GetIt.I<GoogleAdsService>();

  @override
  void initState() {
    super.initState();
    _adsService.loadBannerAd(); // Reklam yüklenmesini başlat
  }

  @override
  void dispose() {
    _adsService.disposeBannerAd(); // Reklamı serbest bırak
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Reklam başarıyla yüklendiğinde göster, yüklenmezse hiç görünmesin
    return _adsService.bannerAd != null
        ? SizedBox(
            width: double.infinity,
            height: widget.height / 2,
            child: AdWidget(ad: _adsService.bannerAd!),
          )
        : const SizedBox(); // Yüklenmeyen reklam için boş widget
  }
}
