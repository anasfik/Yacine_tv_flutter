part of 'settings_bloc.dart';

@immutable
class SettingsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SettingsRequested extends SettingsEvent {
  SettingsRequested();
}

class SettingsUpdated extends SettingsEvent {
  final void Function() onSuccess;
  SettingsUpdated({
    required this.onSuccess,
  });
}

class ShowShareSwitched extends SettingsEvent {
  final bool value;
  ShowShareSwitched({
    required this.value,
  });
}

class ShowAdsSwitched extends SettingsEvent {
  final bool value;
  ShowAdsSwitched({
    required this.value,
  });
}
