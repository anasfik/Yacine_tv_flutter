import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/channel_player/channel_player_cubit.dart';

class PlayerOverlay extends StatefulWidget {
  const PlayerOverlay({
    super.key,
    required this.cubit,
  });
  final ChannelPlayerCubit cubit;

  @override
  State<PlayerOverlay> createState() => _PlayerOverlayState();
}

class _PlayerOverlayState extends State<PlayerOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
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
    return Stack(
      children: <Widget>[
        BlocSelector<ChannelPlayerCubit, ChannelPlayerState, PlayingStatus>(
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
        ),
      ],
    );
  }
}
