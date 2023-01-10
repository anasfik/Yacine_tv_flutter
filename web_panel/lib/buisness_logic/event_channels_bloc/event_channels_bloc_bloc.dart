import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/models/event_match.dart';
import '../../data/repositories/match_events/match_events.dart';

part 'event_channels_bloc_event.dart';
part 'event_channels_bloc_state.dart';

class EventChannelsBlocBloc
    extends Bloc<EventChannelsBlocEvent, EventChannelsBlocState> {
  final MatchEventsRepository matchEventsRepository;

  EventChannelsBlocBloc({
    required this.matchEventsRepository,
  }) : super(const EventChannelsBlocState()) {
    on<MatchEventsRequested>(_matchEventsRequested);
    add(MatchEventsRequested());
  }

  FutureOr<void> _matchEventsRequested(
    MatchEventsRequested event,
    Emitter<EventChannelsBlocState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );
    final matchEvents = await matchEventsRepository.getMatchEvents();
    emit(
      state.copyWith(
        eventMatches: matchEvents,
        isLoading: false,
      ),
    );
  }
}
