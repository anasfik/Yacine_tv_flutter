import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/channel_player/channel_player_cubit.dart';

class PlayButton extends StatefulWidget {
  const PlayButton({
    super.key,
    required this.cubit,
    required this.animationDuration,
  });

  final ChannelPlayerCubit cubit;
  final Duration animationDuration;
  @override
  State<PlayButton> createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    if (widget.cubit.state.playingStatus == PlayingStatus.isPlaying) {
      _animationController.forward();
    }
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ChannelPlayerCubit, ChannelPlayerState, PlayingStatus>(
      bloc: widget.cubit,
      selector: (state) {
        return state.playingStatus;
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            widget.cubit.togglePLaying(_animationController);
          },
          child: Align(
            alignment: Alignment.center,
            child: AnimatedIcon(
              color: Theme.of(context).primaryColor,
              icon: AnimatedIcons.play_pause,
              progress: _animationController,
              size: 40,
            ),
          ),
        );
      },
    );
  }
}
