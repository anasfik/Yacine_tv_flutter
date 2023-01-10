// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'event_match_bloc.dart';

@immutable
abstract class EventMatchEvent {}

class DateTimeSelected extends EventMatchEvent {
  final BuildContext context;
  final VoidCallback onUserNotFinishingTimesSelects;
  DateTimeSelected(
    this.context, {
    required this.onUserNotFinishingTimesSelects,
  });
}

class SaveEventMatch extends EventMatchEvent {
  final VoidCallback onSuccess;
  final VoidCallback onError;
  SaveEventMatch({
    required this.onSuccess,
    required this.onError,
  });
}

