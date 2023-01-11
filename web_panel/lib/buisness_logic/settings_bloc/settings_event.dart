part of 'settings_bloc.dart';

@immutable
class SettingsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SettingsRequested extends SettingsEvent {
  SettingsRequested();
}
