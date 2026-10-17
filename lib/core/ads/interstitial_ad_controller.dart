import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:vehicle_calculator/core/ads/ad_unit_ids.dart';
import 'package:vehicle_calculator/core/config/app_config.dart';

class InterstitialAdController {
  InterstitialAd? _ad;
  DateTime? _lastShownAt;
  bool _isLoading = false;

  Future<void> preload() async {
    if (!AppConfig.adsEnabled || _ad != null || _isLoading) return;

    _isLoading = true;
    final completer = Completer<void>();
    InterstitialAd.load(
      adUnitId: AdUnitIds.interstitial,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _ad = ad;
          _isLoading = false;
          if (!completer.isCompleted) completer.complete();
        },
        onAdFailedToLoad: (_) {
          _ad = null;
          _isLoading = false;
          if (!completer.isCompleted) completer.complete();
        },
      ),
    );
    await completer.future;
  }

  /// Shows an interstitial after a completed calculation if the cooldown elapsed.
  /// Never blocks navigation if the ad is missing or fails.
  Future<void> showAfterSuccessfulCalculation() async {
    if (!AppConfig.adsEnabled) return;

    final lastShownAt = _lastShownAt;
    if (lastShownAt != null &&
        DateTime.now().difference(lastShownAt) <
            AppConfig.interstitialMinInterval) {
      return;
    }

    if (_ad == null) {
      await preload();
      return;
    }

    final completer = Completer<void>();
    final ad = _ad!;
    _ad = null;

    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        if (!completer.isCompleted) completer.complete();
        preload();
      },
      onAdFailedToShowFullScreenContent: (ad, _) {
        ad.dispose();
        if (!completer.isCompleted) completer.complete();
        preload();
      },
    );

    _lastShownAt = DateTime.now();
    await ad.show();
    await completer.future;
  }

  void dispose() {
    _ad?.dispose();
    _ad = null;
  }
}
