import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:vehicle_calculator/core/ads/ad_unit_ids.dart';
import 'package:vehicle_calculator/core/config/app_config.dart';

class AppAdaptiveBanner extends StatefulWidget {
  const AppAdaptiveBanner({super.key});

  @override
  State<AppAdaptiveBanner> createState() => _AppAdaptiveBannerState();
}

class _AppAdaptiveBannerState extends State<AppAdaptiveBanner> {
  BannerAd? _banner;
  bool _ready = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_banner != null || !AppConfig.adsEnabled) return;
    _load();
  }

  Future<void> _load() async {
    final width = MediaQuery.sizeOf(context).width.truncate();
    final size = await AdSize.getLargeAnchoredAdaptiveBannerAdSize(width);
    if (!mounted || size == null) return;

    final banner = BannerAd(
      size: size,
      adUnitId: AdUnitIds.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          if (mounted) setState(() => _ready = true);
        },
        onAdFailedToLoad: (ad, _) {
          ad.dispose();
          if (mounted) {
            setState(() {
              _banner = null;
              _ready = false;
            });
          }
        },
      ),
    );

    _banner = banner;
    await banner.load();
  }

  @override
  void dispose() {
    _banner?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final banner = _banner;
    if (!_ready || banner == null) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      width: banner.size.width.toDouble(),
      height: banner.size.height.toDouble(),
      child: AdWidget(ad: banner),
    );
  }
}
