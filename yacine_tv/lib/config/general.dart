import 'package:yacine_tv/data/models/app_settings.dart';

class Configs {
  static String environmentFilePath = '.env';
  static String lightThemePath = 'assets/theme.json';
  static String menuImageCoverToShowWhenOriginalOneFails =
      'assets/YOUR_IMAGE.png';

  static bool loadMenuItemsLazily = false;
  static bool loadAppSettingsLazily = false;
  static const AppSettings initialSettings = AppSettings(
    appEmail: '',
    appAuthor: '',
    appLogoCover: '',
    appPrivacyPolicy: '',
    appVersion: '',
    appWebsite: '',
    admobAppId: '',
    admobBannerId: '',
    admobInterstitialId: '',
    showAds: false,
    showShare: true,
  );
}
