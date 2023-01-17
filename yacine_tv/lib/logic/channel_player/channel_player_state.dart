part of 'channel_player_cubit.dart';

enum PlayingStatus {
  isPlaying,
  isPaused,
}

@immutable
abstract class ChannelPlayerState extends Equatable {
  final bool isInitialized;
  final bool isDuringInitialization;
  final String? error;
  final PlayingStatus playingStatus;
  @override
  List<Object?> get props =>
      [isInitialized, isDuringInitialization, playingStatus, error];

  const ChannelPlayerState({
    this.isInitialized = false,
    this.isDuringInitialization = false,
    this.playingStatus = PlayingStatus.isPaused,
    this.error,
  });
}

class ChannelPlayerInitializing extends ChannelPlayerState {
  const ChannelPlayerInitializing({
    super.isDuringInitialization = true,
  });
}

class ChannelPlayerReady extends ChannelPlayerState {
  const ChannelPlayerReady({
    super.isInitialized = true,
  });
}

class ChannelPlayerError extends ChannelPlayerState {
  const ChannelPlayerError({
    required super.error,
  });
}

class ChannelPlayerPlaying extends ChannelPlayerState {
  const ChannelPlayerPlaying({
    super.playingStatus = PlayingStatus.isPlaying,
  });
}

class ChannelPlayerPaused extends ChannelPlayerState {
  const ChannelPlayerPaused({
    super.playingStatus = PlayingStatus.isPaused,
  });
}