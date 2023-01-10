// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'event_match_bloc.dart';

class EventMatchState extends Equatable {
  final DateTime matchDateTime;
  final TimeOfDay matchTimeOfDay;

  const EventMatchState({
    required this.matchDateTime,
    required this.matchTimeOfDay,
  });

  @override
  List<Object?> get props => [matchDateTime, matchTimeOfDay];

  EventMatchState copyWith({
    DateTime? matchDateTime,
    TimeOfDay? matchTimeOfDay,
  }) {
    return EventMatchState(
      matchDateTime: matchDateTime ?? this.matchDateTime,
      matchTimeOfDay: matchTimeOfDay ?? this.matchTimeOfDay,
    );
  }
}
