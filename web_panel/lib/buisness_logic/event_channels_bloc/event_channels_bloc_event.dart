part of 'event_channels_bloc_bloc.dart';

@immutable
abstract class EventChannelsBlocEvent {}

class MatchEventsRequested extends EventChannelsBlocEvent {
  MatchEventsRequested();
}
