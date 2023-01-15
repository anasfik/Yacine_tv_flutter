// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';

import '../../config/general.dart';

@immutable
class AppSettings {
  final String appLogoCover;
  final String appVersion;
  final String appAuthor;
  final String appEmail;
  final String appWebsite;
  final String appPrivacyPolicy;
  final bool showAds;
  final bool showShare;
  final String admobAppId;
  final String admobBannerId;
  final String admobInterstitialId;

  @override
  int get hashCode {
    return appLogoCover.hashCode ^
        appVersion.hashCode ^
        appAuthor.hashCode ^
        appEmail.hashCode ^
        appWebsite.hashCode ^
        appPrivacyPolicy.hashCode ^
        showAds.hashCode ^
        showShare.hashCode ^
        admobAppId.hashCode ^
        admobBannerId.hashCode ^
        admobInterstitialId.hashCode;
  }

  const AppSettings({
    required this.appLogoCover,
    required this.appVersion,
    required this.appAuthor,
    required this.appEmail,
    required this.appWebsite,
    required this.appPrivacyPolicy,
    required this.showAds,
    required this.showShare,
    required this.admobAppId,
    required this.admobBannerId,
    required this.admobInterstitialId,
  });

  factory AppSettings.fromMap(Map<String, dynamic> json) => AppSettings(
        appLogoCover: json["app_logo_cover"],
        appVersion: json["app_version"],
        appAuthor: json["app_author"],
        appEmail: json["app_email"],
        appWebsite: json["app_website"],
        appPrivacyPolicy: json["app_privacy_policy"],
        showAds: json["show_ads"],
        showShare: json["show_share"],
        admobAppId: json["admob_app_id"],
        admobBannerId: json["admob_banner_id"],
        admobInterstitialId: json["admob_interstitial_id"],
      );

  factory AppSettings.raw() {
    return Configs.initialSettings;
  }

  Map<String, dynamic> toMap() => {
        "app_logo_cover": appLogoCover,
        "app_version": appVersion,
        "app_author": appAuthor,
        "app_email": appEmail,
        "app_website": appWebsite,
        "app_privacy_policy": appPrivacyPolicy,
        "show_ads": showAds,
        "show_share": showShare,
        "admob_app_id": admobAppId,
        "admob_banner_id": admobBannerId,
        "admob_interstitial_id": admobInterstitialId,
      };

  @override
  bool operator ==(covariant AppSettings other) {
    if (identical(this, other)) return true;

    return other.appLogoCover == appLogoCover &&
        other.appVersion == appVersion &&
        other.appAuthor == appAuthor &&
        other.appEmail == appEmail &&
        other.appWebsite == appWebsite &&
        other.appPrivacyPolicy == appPrivacyPolicy &&
        other.showAds == showAds &&
        other.showShare == showShare &&
        other.admobAppId == admobAppId &&
        other.admobBannerId == admobBannerId &&
        other.admobInterstitialId == admobInterstitialId;
  }
}
