import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:yacine_tv/core/lang/en.dart';

import '../../../../core/core.dart';
import '../../../../data/models/channel.dart';
import '../../../../data/models/event_matches.dart';
import '../../../../logic/channel_player/channel_player_cubit.dart';
import 'player_overlay.dart';

class EventMatchScreen extends StatefulWidget {
  const EventMatchScreen({
    super.key,
    required this.eventMatch,
  });

  final EventMatch eventMatch;

  @override
  State<EventMatchScreen> createState() => _EventMatchScreenState();
}

class _EventMatchScreenState extends State<EventMatchScreen> {
  late ChannelPlayerCubit cubit;

  late final validChannelStream = widget.eventMatch.channelQuality
      .where((element) => element.isValid())
      .toList();

  @override
  void initState() {
    super.initState();

    final link = validChannelStream.first.channelUrl;
    cubit = ChannelPlayerCubit(link!);
    Core.enableFullScreenMode();
  }

  @override
  void dispose() {
    super.dispose();
    Core.setScreenOrientationToPortrait();
    cubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<ChannelPlayerCubit, ChannelPlayerState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is ChannelPlayerInitializing) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ChannelPlayerReady ||
              cubit.videoPlayerController.value.isInitialized) {
            return Stack(
              fit: StackFit.expand,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: Core.deviceAspectRatio(context),
                  child: VideoPlayer(cubit.videoPlayerController),
                ),
                PlayerOverlay(
                  cubit: cubit,
                  channelsQuality: validChannelStream,
                ),
              ],
            );
          } else {
            final error = state.error;

            return Center(
                child: Text(
              error ?? L10n.error,
              style: TextStyle(
                color: Colors.white,
              ),
            ));
          }
        },
      ),
    );
  }
}
