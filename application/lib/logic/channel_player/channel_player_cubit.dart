import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'package:yacine_tv/config/general.dart';
part 'channel_player_state.dart';

class ChannelPlayerCubit extends Cubit<ChannelPlayerState> {
  /// This is the URL of the stream that will be played.
  final String streamUrl;

  late VideoPlayerController _controller;

  /// This is the [VideoPlayerController] object that will be used to control the video player.
  VideoPlayerController get videoPlayerController => _controller;

  ChannelPlayerCubit(this.streamUrl) : super(const ChannelPlayerReady()) {
    _controller = VideoPlayerController.network(
      streamUrl,
    );

    _initializeController(autoPlay: Configs.autoPlay);
  }

  /// This function is used to dispose the [VideoPlayerController] object, and free resources.
  @override
  Future<void> close() async {
    await _controller.pause();
    await _controller.dispose();
    super.close();
  }

  /// This function is used to toggle the playing state of an animation.
  ///
  /// It takes in an AnimationController object as a parameter, which is used to control the animation.
  ///
  /// If the AnimationController object passed in is currently playing, the function will pause it and reverse the animation.
  ///
  /// If the AnimationController object passed in is not currently playing, the function will play it and move the animation forward.
  void togglePLaying(AnimationController animationController) {
    if (_controller.value.isPlaying) {
      _controller.pause();
      animationController.reverse();
    } else {
      _controller.play();
      animationController.forward();
    }
  }

  /// This function is used to toggle the visibility of the player overlay.
  /// If the overlay is currently visible, the function will hide it.
  /// If the overlay is currently hidden, the function will show it.
  void togglePlayerOverlay() {
    if (state.showPlayerOverlay) {
      emit(const ChannelPlayerOverlayHidden());
    } else {
      emit(const ChannelPlayerOverlayVisible());
    }
  }

  /// This function is used to change the channel that is being played.
  /// It takes in a String `url` as a parameter, which is the URL of the stream that will be played.
  /// Example:
  /// ```dart
  /// await changeChannel('https://example.com/stream.m3u8');
  /// ```
  ///
  Future<void> changeChannel(String url) async {
    await _controller.pause();
    await _controller.dispose();
    _controller = VideoPlayerController.network(url);
    _initializeController(autoPlay: Configs.autoPlay);
  }

  /// This function is used to initialize the [VideoPlayerController] object.
  /// It takes in a boolean `autoPlay` as a parameter, which is used to determine whether the video should start playing automatically after initialization.
  /// Example:
  /// ```dart
  /// await _initializeController(autoPlay: true);
  /// ```
  Future<void> _initializeController({bool autoPlay = false}) async {
    try {
      emit(const ChannelPlayerInitializing());
      await _controller.initialize();
      emit(const ChannelPlayerReady());
      if (autoPlay) {
        await _play();
      }
    } catch (e) {
      emit(ChannelPlayerError(error: e.toString()));
    }
  }

  /// This function is used to play the video.
  /// Example:
  /// ```dart
  /// await _play();
  /// ```
  ///
  Future<void> _play() async {
    try {
      await _controller.play();
      emit(const ChannelPlayerPlaying());
    } catch (e) {
      print(e.toString());
    }
  }
}
