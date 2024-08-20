import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../data/services/google_ads_service.dart';

class AdMobBanner extends StatefulWidget {
  final double height;
  final Color backgroundColor;

  const AdMobBanner({
    Key? key,
    this.height = 90,
    this.backgroundColor = Colors.grey,
  }) : super(key: key);

  @override
  _AdMobBannerState createState() => _AdMobBannerState();
}

class _AdMobBannerState extends State<AdMobBanner> {
  final GoogleAdsService _adsService = GetIt.I<GoogleAdsService>();

  @override
  void initState() {
    super.initState();
    _adsService.loadBannerAd();
  }

  @override
  void dispose() {
    _adsService.disposeBannerAd();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _adsService.bannerAd != null
        ? SizedBox(
            width: double.infinity,
            height: _adsService.bannerAd!.size.height.toDouble(),
            child: AdWidget(ad: _adsService.bannerAd!),
          )
        : Container(
            width: double.infinity,
            height: widget.height,
            child: Center(
              child: Text(
                'Ad loading...',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
  }
}
