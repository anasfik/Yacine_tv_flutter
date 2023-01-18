import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import "package:meta/meta.dart";
import 'package:yacine_tv/config/general.dart';
part 'channel_player_state.dart';

class ChannelPlayerCubit extends Cubit<ChannelPlayerState> {
  final String initialStreamLink;
  late VideoPlayerController _controller;

  VideoPlayerController get videoPlayerController => _controller;

  ChannelPlayerCubit(this.initialStreamLink)
      : super(const ChannelPlayerReady()) {
    _controller = VideoPlayerController.network(
      initialStreamLink,
    );
    _listenOnVideoControllerChanges();

    _initializeController(autoPlay: Configs.autoPlay);
  }

  @override
  Future<void> close() async {
    _controller.pause();
    _controller.removeListener(() {});
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

  void _listenOnVideoControllerChanges() {
    print(_controller.value.position);
    _controller.addListener(() {
      if (_controller.value.isPlaying) {
        emit(const ChannelPlayerPlaying());
      } else if (!_controller.value.isPlaying) {
        emit(const ChannelPlayerPaused());
      }
    });
  }
}
