part of 'event_matches_cubit.dart';

abstract class EventMatchesState extends Equatable {
  final bool isLoading;
  final List<EventMatch>? eventMatches;
  final String? error;

  @override
  List<Object?> get props => [isLoading, eventMatches, error];

  const EventMatchesState({
    this.isLoading = false,
    this.eventMatches,
    this.error,
  });
}

class EventMatchesLoading extends EventMatchesState {
  const EventMatchesLoading({
    super.isLoading = true,
  });
}

class EventMatchesLoaded extends EventMatchesState {
  const EventMatchesLoaded({
    required super.eventMatches,
  });
}

class EventMatchesError extends EventMatchesState {
  const EventMatchesError({
    required super.error,
  });
}
