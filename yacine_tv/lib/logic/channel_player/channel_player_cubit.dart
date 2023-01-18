import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import "package:meta/meta.dart";
import 'package:yacine_tv/config/general.dart';
part 'channel_player_state.dart';

class ChannelPlayerCubit extends Cubit<ChannelPlayerState> {
  late VideoPlayerController _controller;

  VideoPlayerController get videoPlayerController => _controller;

  final String streamUrl;

  ChannelPlayerCubit(this.streamUrl) : super(const ChannelPlayerReady()) {
    _controller = VideoPlayerController.network(
      streamUrl,
    );

    _initializeController(autoPlay: Configs.autoPlay);
  }

  @override
  Future<void> close() async {
    _controller.pause();
    _controller.dispose();
    super.close();
  }

  void togglePLaying(AnimationController animationController) {
    if (_controller.value.isPlaying) {
      _controller.pause();
      animationController.reverse();
    } else {
      _controller.play();
      animationController.forward();
    }
  }

  void togglePlayerOverlay() {
    if (state.showPlayerOverlay) {
      emit(const ChannelPlayerOverlayHidden());
    } else {
      emit(const ChannelPlayerOverlayVisible());
    }
  }

  Future<void> changeChannel(String url) async {
    await _controller.pause();
    await _controller.dispose();
    _controller = VideoPlayerController.network(url);
    _initializeController(autoPlay: Configs.autoPlay);
  }

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

  Future<void> _play() async {
    try {
      await _controller.play();
      emit(const ChannelPlayerPlaying());
    } catch (e) {
      print(e.toString());
    }
  }
}
