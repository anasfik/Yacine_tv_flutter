import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/app_settings.dart';
import '../../data/repositories/settings/settings.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository repository;

  SettingsCubit(this.repository)
      : super(SettingsLoading(
          settings: AppSettings.raw(),
        )) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
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
