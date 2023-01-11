import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../data/models/app_settings.dart';
import '../../data/repositories/settings_repository/settings_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository settingsRepository;

  late final TextEditingController privacyController;
  late final TextEditingController admobAppIdController;
  late final TextEditingController admobBannerIdController;
  late final TextEditingController admobInterstitialIdController;
  late final TextEditingController logoCoverController;
  late final TextEditingController emailController;
  late final TextEditingController websiteController;
  late final TextEditingController versionController;
  late final TextEditingController authorController;

  SettingsBloc(this.settingsRepository) : super(SettingsState()) {
    _initController();
    on<SettingsRequested>(_onSettingsRequested);
    on<ShowShareSwitched>(_showShareSwitched);
    on<ShowAdsSwitched>(_showAdsSwitched);
    on<SettingsUpdated>(_onSettingsUpdated);
    add(SettingsRequested());
  }

  FutureOr<void> _onSettingsRequested(
    SettingsRequested event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final settings = await settingsRepository.getSettings();
    print(settings);
    _updateControllers(settings);

    emit(state.copyWith(
      isLoading: false,
      settings: settings,
      showAds: settings.showAds,
      showShare: settings.showShare,
    ));
  }

  void _updateControllers(AppSettings settings) {
    privacyController.text = settings.appPrivacyPolicy;
    admobAppIdController.text = settings.admobAppId;
    admobBannerIdController.text = settings.admobBannerId;
    admobInterstitialIdController.text = settings.admobInterstitialId;
    logoCoverController.text = settings.appLogoCover;
    emailController.text = settings.appEmail;
    websiteController.text = settings.appWebsite;
    versionController.text = settings.appVersion;
    authorController.text = settings.appAuthor;
  }

  _initController() {
    privacyController = TextEditingController(text: "");
    admobAppIdController = TextEditingController(text: "");
    admobBannerIdController = TextEditingController(text: "");
    admobInterstitialIdController = TextEditingController(text: "");
    logoCoverController = TextEditingController(text: "");
    emailController = TextEditingController(text: "");
    websiteController = TextEditingController(text: "");
    versionController = TextEditingController(text: "");
    authorController = TextEditingController(text: "");
  }

  FutureOr<void> _onSettingsUpdated(
    SettingsUpdated event,
    Emitter<SettingsState> emit,
  ) async {
    final newSettings = _createSettings();
    await settingsRepository.updateSettings(newSettings);
    emit(state.copyWith(settings: newSettings));
    event.onSuccess();
  }

  AppSettings _createSettings() {
    return AppSettings(
      showAds: state.showAds,
      showShare: state.showShare,
      appAuthor: authorController.text,
      appPrivacyPolicy: privacyController.text,
      admobAppId: admobAppIdController.text,
      admobBannerId: admobBannerIdController.text,
      admobInterstitialId: admobInterstitialIdController.text,
      appLogoCover: logoCoverController.text,
      appEmail: emailController.text,
      appWebsite: websiteController.text,
      appVersion: versionController.text,
    );
  }

  FutureOr<void> _showShareSwitched(
    ShowShareSwitched event,
    Emitter<SettingsState> emit,
  ) {
    emit(state.copyWith(showShare: !state.showShare));
  }

  FutureOr<void> _showAdsSwitched(
    ShowAdsSwitched event,
    Emitter<SettingsState> emit,
  ) {
    emit(state.copyWith(showAds: !state.showAds));
  }
}
