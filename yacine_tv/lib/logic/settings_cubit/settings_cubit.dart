import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../data/models/app_settings.dart';
import '../../data/repositories/settings/settings.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  /// This is the repository that will be used to fetch the app settings.
  final SettingsRepository repository;

  ///
  BannerAd? bannerAd;

  SettingsCubit(this.repository)
      : super(SettingsLoading(
          settings: AppSettings.raw(),
        )) {
    loadSettings();
  }

  /// This function is used to load the app settings.
  /// It will emit a [SettingsLoaded] state if the settings are loaded successfully.
  /// It will emit a [SettingsError] state if the settings are not loaded successfully.
  /// It will emit a [SettingsLoading] state if the settings are being loaded.
  /// Example:
  /// ```dart
  /// await loadSettings();
  /// ```
  Future<void> loadSettings() async {
    try {
      emit(const SettingsLoading());
      final settings = await repository.getSettings();
      _startAds(settings.admobBannerId);

      print(settings.appLogoCover);
      emit(SettingsLoaded(settings: settings));
    } catch (e) {
      emit(SettingsError(
        settings: AppSettings.raw(),
        error: e.toString(),
      ));
    }
  }

  void _startAds(String bannerAdId) {
    bannerAd = BannerAd(
      adUnitId: bannerAdId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          emit(state.copyWith(adLoaded: true));
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
      ),
    )..load();
  }
}
