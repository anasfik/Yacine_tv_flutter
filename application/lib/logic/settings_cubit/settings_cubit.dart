import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/app_settings.dart';
import '../../data/repositories/settings/settings.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  /// This is the repository that will be used to fetch the app settings.
  final SettingsRepository repository;

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
      emit(SettingsLoaded(settings: settings));
    } catch (e) {
      emit(SettingsError(
        settings: AppSettings.raw(),
        error: e.toString(),
      ));
    }
  }
}
