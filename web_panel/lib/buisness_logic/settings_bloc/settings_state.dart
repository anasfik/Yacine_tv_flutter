// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'settings_bloc.dart';

@immutable
class SettingsState extends Equatable {
  final bool isLoading;
  final AppSettings? settings;

  final bool showAds;
  final bool showShare;

  const SettingsState({
    this.isLoading = false,
    this.settings,
    this.showAds = false,
    this.showShare = false,
  });

  @override
  List<Object?> get props => [isLoading, settings, showAds, showShare];

  SettingsState copyWith({
    bool? isLoading,
    AppSettings? settings,
    bool? showAds,
    bool? showShare,
  }) {
    return SettingsState(
      isLoading: isLoading ?? this.isLoading,
      settings: settings ?? this.settings,
      showAds: showAds ?? this.showAds,
      showShare: showShare ?? this.showShare,
    );
  }
}
