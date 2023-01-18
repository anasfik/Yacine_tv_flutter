import 'package:flutter/material.dart';
import 'package:yacine_tv/data/models/event_matches.dart';
import '../../../../logic/channel_player/channel_player_cubit.dart';
import 'play_button.dart';

class PlayerOverlay extends StatelessWidget {
  const PlayerOverlay({
    super.key,
    required this.cubit,
    required this.channelsQuality,
  });
  final ChannelPlayerCubit cubit;
  final List<ChannelQuality> channelsQuality;

  final animationDuration = const Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

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
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                child: Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  runAlignment: WrapAlignment.center,
                  children: List.generate(channelsQuality.length, (index) {
                    final current = channelsQuality[index];

                    return ElevatedButton(
                      onPressed: () {
                        cubit.changeChannel(current.channelUrl!);
                      },
                      child: Text(current.quality!),
                    );
                  }),
                ),
              ),
              if (cubit.state.isBuffering) ...[
                const Center(
                  child: CircularProgressIndicator(),
                ),
              ] else ...[
                PlayButton(
                  animationDuration: animationDuration,
                  cubit: cubit,
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
