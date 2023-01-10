import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:web_panel/data/repositories/match_events/match_events.dart';

import '../../data/models/event_match.dart';

part 'event_match_event.dart';
part 'event_match_state.dart';

class EventMatchBloc extends Bloc<EventMatchEvent, EventMatchState> {
  final EventMatch eventMatch;

  late final TextEditingController firstTeamNameController;
  late final TextEditingController firstTeamImageController;
  late final TextEditingController secondTeamNameController;
  late final TextEditingController secondTeamImageController;
  late final TextEditingController cupNameController;
  late final TextEditingController channelNameController;
  late final TextEditingController commenterNameController;

  final MatchEventsRepository matchEventsRepository;
  EventMatchBloc({
    required this.eventMatch,
    required this.matchEventsRepository,
  }) : super(EventMatchState(
          matchDateTime: eventMatch.dateOfMatchWithTime,
          matchTimeOfDay: TimeOfDay.fromDateTime(
            eventMatch.dateOfMatchWithTime,
          ),
        )) {
    _initControllers(eventMatch);
    on<DateTimeSelected>(_dateTimeSelected);
    on<SaveEventMatch>(_saveEventMatch);

  }

  void _initControllers(EventMatch eventMatch) {
    channelNameController = TextEditingController(
      text: eventMatch.channelName,
    );

    cupNameController = TextEditingController(
      text: eventMatch.cupName,
    );

    firstTeamNameController = TextEditingController(
      text: eventMatch.firstTeam,
    );

    firstTeamImageController = TextEditingController(
      text: eventMatch.firstTeamLogo,
    );

    secondTeamNameController = TextEditingController(
      text: eventMatch.secondTeam,
    );

    secondTeamImageController = TextEditingController(
      text: eventMatch.secondTeamLogo,
    );
    commenterNameController = TextEditingController(
      text: eventMatch.commenterName,
    );
  }

  FutureOr<void> _dateTimeSelected(
    DateTimeSelected event,
    Emitter<EventMatchState> emit,
  ) async {
    DateTime? selectedDate;
    TimeOfDay? selectedTimeOfDay;
    selectedDate = await showDatePicker(
      context: event.context,
      initialDate: state.matchDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (selectedDate != null) {
      selectedTimeOfDay = await showTimePicker(
        context: event.context,
        initialTime: state.matchTimeOfDay,
      );
    }

    if (selectedTimeOfDay == null || selectedDate == null) {
      event.onUserNotFinishingTimesSelects();
      return;
    }

    emit(
      state.copyWith(
        matchDateTime: DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTimeOfDay.hour,
          selectedTimeOfDay.minute,
        ),
      ),
    );
  }

  FutureOr<void> _saveEventMatch(
    SaveEventMatch event,
    Emitter<EventMatchState> emit,
  ) async {
    final createdEventChannel = _createEventChannel();
    await matchEventsRepository.createMatchEvent(createdEventChannel);
    event.onSuccess();
  }

  EventMatch _createEventChannel() {
    return EventMatch(
      id: "_",
      firstTeam: firstTeamNameController.text,
      firstTeamLogo: firstTeamImageController.text,
      secondTeam: secondTeamNameController.text,
      secondTeamLogo: secondTeamImageController.text,
      cupName: cupNameController.text,
      channelName: channelNameController.text,
      dateOfMatchWithTime: state.matchDateTime,
      commenterName: commenterNameController.text,
      channelsQuality: [],
    );
  }


}
