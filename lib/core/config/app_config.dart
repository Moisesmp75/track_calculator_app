/// Single place to switch environments. Change [environment] (or the values
/// below) — no Flutter flavors.
///
/// AdMob: official Google test IDs work without an AdMob account.
/// Replace them with your real unit IDs only after you create the account.
/// Native Android/iOS still need the AdMob App ID in the manifest / Info.plist
/// when you add the ads SDK.
enum AppEnvironment { dev, staging, prod }

class AppConfig {
  static const environment = AppEnvironment.dev;

  static bool get isProd => environment == AppEnvironment.prod;

  static bool get enableHttpLogs => !isProd;

  static const apiBaseUrl = 'http://127.0.0.1:3000/api';

  static const adMob = AdMobConfig(
    androidAppId: 'ca-app-pub-3940256099942544~3347511713',
    iosAppId: 'ca-app-pub-3940256099942544~1458002511',
    bannerAdUnitIdAndroid: 'ca-app-pub-3940256099942544/6300978111',
    bannerAdUnitIdIos: 'ca-app-pub-3940256099942544/2934735716',
    interstitialAdUnitIdAndroid: 'ca-app-pub-3940256099942544/1033173712',
    interstitialAdUnitIdIos: 'ca-app-pub-3940256099942544/4411468910',
    rewardedAdUnitIdAndroid: 'ca-app-pub-3940256099942544/5224354917',
    rewardedAdUnitIdIos: 'ca-app-pub-3940256099942544/1712485313',
  );

  /// Fill when you add Firebase (FCM / Analytics). The native
  /// `google-services.json` / `GoogleService-Info.plist` files are still required.
  static const firebase = FirebaseConfig(
    projectId: '',
    apiKey: '',
    appIdAndroid: '',
    appIdIos: '',
    messagingSenderId: '',
    storageBucket: '',
  );
}

class AdMobConfig {
  const AdMobConfig({
    required this.androidAppId,
    required this.iosAppId,
    required this.bannerAdUnitIdAndroid,
    required this.bannerAdUnitIdIos,
    required this.interstitialAdUnitIdAndroid,
    required this.interstitialAdUnitIdIos,
    required this.rewardedAdUnitIdAndroid,
    required this.rewardedAdUnitIdIos,
  });

  final String androidAppId;
  final String iosAppId;
  final String bannerAdUnitIdAndroid;
  final String bannerAdUnitIdIos;
  final String interstitialAdUnitIdAndroid;
  final String interstitialAdUnitIdIos;
  final String rewardedAdUnitIdAndroid;
  final String rewardedAdUnitIdIos;
}

class FirebaseConfig {
  const FirebaseConfig({
    required this.projectId,
    required this.apiKey,
    required this.appIdAndroid,
    required this.appIdIos,
    required this.messagingSenderId,
    required this.storageBucket,
  });

  final String projectId;
  final String apiKey;
  final String appIdAndroid;
  final String appIdIos;
  final String messagingSenderId;
  final String storageBucket;
}
