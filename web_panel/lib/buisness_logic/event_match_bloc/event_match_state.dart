// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'event_match_bloc.dart';

class EventMatchState extends Equatable {
  final DateTime matchDateTime;
  final TimeOfDay matchTimeOfDay;
  final List<ChannelQuality> channels;

  const EventMatchState({
    required this.matchDateTime,
    required this.matchTimeOfDay,
    this.channels = const [],
  });

  @override
  List<Object?> get props => [matchDateTime, matchTimeOfDay, channels];

  EventMatchState copyWith({
    DateTime? matchDateTime,
    TimeOfDay? matchTimeOfDay,
    List<ChannelQuality>? channels,
  }) {
    return EventMatchState(
      matchDateTime: matchDateTime ?? this.matchDateTime,
      matchTimeOfDay: matchTimeOfDay ?? this.matchTimeOfDay,
      channels: channels ?? this.channels,
    );
  }
}
