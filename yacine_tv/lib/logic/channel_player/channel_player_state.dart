part of 'channel_player_cubit.dart';

enum PlayingStatus {
  isPlaying,
  isPaused,
}

@immutable
abstract class ChannelPlayerState extends Equatable {
  final bool isInitialized;
  final bool isDuringInitialization;
  final PlayingStatus playingStatus;
  final bool showPlayerOverlay;
  final String? error;

  @override
  List<Object?> get props => [
        isInitialized,
        isDuringInitialization,
        playingStatus,
        showPlayerOverlay,
        error,
      ];

  const ChannelPlayerState({
    this.isInitialized = false,
    this.isDuringInitialization = false,
    this.showPlayerOverlay = false,
    this.playingStatus = PlayingStatus.isPlaying,
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

class ChannelPlayerOverlayVisible extends ChannelPlayerState {
  const ChannelPlayerOverlayVisible({
    super.showPlayerOverlay = true,
  });
}

class ChannelPlayerOverlayHidden extends ChannelPlayerState {
  const ChannelPlayerOverlayHidden({
    super.showPlayerOverlay = false,
  });
}
