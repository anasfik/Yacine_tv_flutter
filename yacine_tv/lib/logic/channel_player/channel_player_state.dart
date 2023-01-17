part of 'channel_player_cubit.dart';

@immutable
abstract class ChannelPlayerState extends Equatable {
  final bool isInitialized;
  final bool isDuringInitialization;
  final String? error;

  @override
  List<Object?> get props => [isInitialized, isDuringInitialization, error];

  const ChannelPlayerState({
    this.isInitialized = false,
    this.isDuringInitialization = false,
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
