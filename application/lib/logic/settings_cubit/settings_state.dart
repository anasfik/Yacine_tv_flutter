part of 'settings_cubit.dart';

abstract class SettingsState extends Equatable {
  final bool isLoading;
  final AppSettings? settings;
  final String? error;

  @override
  List<Object?> get props => [isLoading, settings, error];

  const SettingsState({
    this.settings,
    this.isLoading = true,
    this.error,
  });
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
