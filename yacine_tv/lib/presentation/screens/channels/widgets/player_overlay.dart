import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/channel.dart';
import '../../../../logic/channel_player/channel_player_cubit.dart';
import 'play_button.dart';

class PlayerOverlay extends StatelessWidget {
  const PlayerOverlay({
    super.key,
    required this.cubit,
    required this.channel,
  });
  final ChannelPlayerCubit cubit;
  final Channel channel;

  final animationDuration = const Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    print("a");

    return GestureDetector(
      onTap: () {
        cubit.togglePlayerOverlay();
      },
      child: Container(
        width: mq.size.width,
        height: mq.size.height,
        color: Colors.blue.withOpacity(0.5),
        child: AnimatedOpacity(
          opacity: cubit.state.showPlayerOverlay ? 1 : 0,
          duration: animationDuration,
          child: PlayButton(
            animationDuration: animationDuration,
            cubit: cubit,
          ),
        ),
      ),
    );
  }
}
