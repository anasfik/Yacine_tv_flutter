import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../data/repositories/settings_repository/settings_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository settingsRepository;
  late final TextEditingController privacyController;
  SettingsBloc(this.settingsRepository) : super(const SettingsState()) {
    _initController();
    on<SettingsRequested>(_onSettingsRequested);
    add(SettingsRequested());
  }

  _initController() {
    privacyController = TextEditingController();
  }

  FutureOr<void> _onSettingsRequested(
    SettingsRequested event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final settings = await SettingsRepository.getSettings();
    emit(state.copyWith(isLoading: false));
  }
}
