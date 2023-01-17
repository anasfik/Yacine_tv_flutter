import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yacine_tv/config/general.dart';
import 'package:yacine_tv/core/extensions/date.dart';

import '../../data/models/event_matches.dart';
import '../../data/repositories/event_match/event_matches.dart';
part 'event_matches_state.dart';

class EventMatchesCubit extends Cubit<EventMatchesState> {
  final MatchEventsRepository repository;

  EventMatchesCubit(this.repository) : super(const EventMatchesLoading()) {
    loadEventMatches();
  }

  Future<void> loadEventMatches() async {
    try {
      emit(const EventMatchesLoading());

      List<EventMatch> eventMatches = await repository.getMatchEvents();

      if (Configs.filterOnlyTodayEventMatches) {
        eventMatches = eventMatches
            .where((element) => element.dateOfMatchWithTime.isToday())
            .toList();
      }

      emit(EventMatchesLoaded(eventMatches: eventMatches));
    } catch (e) {
      emit(EventMatchesError(error: e.toString()));
    }
  }
}
