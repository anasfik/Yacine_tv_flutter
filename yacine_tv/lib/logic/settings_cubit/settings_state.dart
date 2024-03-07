part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final bool isLoading;
  final AppSettings? settings;
  final String? error;
  final bool adLoaded;
  @override
  List<Object?> get props => [
        isLoading,
        settings,
        error,
        adLoaded,
      ];

  const SettingsState({
    this.settings,
    this.isLoading = true,
    this.error,
    this.adLoaded = false,
  });

  SettingsState copyWith({
    bool? isLoading,
    AppSettings? settings,
    String? error,
    bool? adLoaded,
  }) {
    return SettingsState(
      isLoading: isLoading ?? this.isLoading,
      settings: settings ?? this.settings,
      error: error ?? this.error,
      adLoaded: adLoaded ?? this.adLoaded,
    );
  }
}

class SettingsLoading extends SettingsState {
  const SettingsLoading({
    super.settings,
    super.isLoading = true,
  });
}

class SettingsLoaded extends SettingsState {
  const SettingsLoaded({
    required super.settings,
    super.isLoading = false,
  });
}

class SettingsError extends SettingsState {
  const SettingsError({
    required super.error,
    super.settings,
    super.isLoading = false,
  });
}
