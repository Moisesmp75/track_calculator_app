import 'dart:io';

import 'package:vehicle_calculator/core/config/app_config.dart';

class AdUnitIds {
  static String get banner {
    return Platform.isIOS
        ? AppConfig.adMob.bannerAdUnitIdIos
        : AppConfig.adMob.bannerAdUnitIdAndroid;
  }

  static String get interstitial {
    return Platform.isIOS
        ? AppConfig.adMob.interstitialAdUnitIdIos
        : AppConfig.adMob.interstitialAdUnitIdAndroid;
  }
}
