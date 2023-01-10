// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'event_channels_bloc_bloc.dart';

class EventChannelsBlocState extends Equatable {
  final bool isLoading;
  final List<EventMatch>? eventMatches;

  const EventChannelsBlocState({
    this.isLoading = false,
    this.eventMatches,
  });

  @override
  List<Object?> get props => [isLoading, eventMatches];

  EventChannelsBlocState copyWith({
    bool? isLoading,
    List<EventMatch>? eventMatches,
  }) {
    return EventChannelsBlocState(
      isLoading: isLoading ?? this.isLoading,
      eventMatches: eventMatches ?? this.eventMatches,
    );
  }
}
