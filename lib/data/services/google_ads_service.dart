// ignore_for_file: avoid_print

import 'package:TiDo/utils/Constant/app_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GoogleAdsService {
  BannerAd? _bannerAd;
  BannerAdListener? _bannerAdListener;

  GoogleAdsService() {
    _bannerAdListener = BannerAdListener(
      onAdLoaded: (Ad ad) {
        if (kDebugMode) {
          print('BannerAd loaded.');
        }
      },
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        if (kDebugMode) {
          print('BannerAd failed to load: $error');
        }
        ad.dispose();
        _bannerAd = null; // Dispose of the failed ad
      },
      onAdOpened: (Ad ad) => print('BannerAd opened.'),
      onAdClosed: (Ad ad) => print('BannerAd closed.'),
    );
  }

  BannerAd? loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: APPContants.adUniBannerId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: _bannerAdListener!,
    );
    _bannerAd!.load();
    return _bannerAd;
  }

  BannerAd? get bannerAd => _bannerAd;

  void disposeBannerAd() {
    _bannerAd?.dispose();
    _bannerAd = null;
  }
}
