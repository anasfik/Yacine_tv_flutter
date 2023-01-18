import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:yacine_tv/core/lang/en.dart';
import 'package:yacine_tv/presentation/screens/general/loading.dart';

import '../../../../core/core.dart';
import '../../../../data/models/event_matches.dart';
import '../../../../logic/channel_player/channel_player_cubit.dart';
import '../../../config/colors.dart';
import 'player_overlay.dart';

import '../../../screens/general/error.dart' as ew;

class EventMatchScreen extends StatefulWidget {
  final EventMatch eventMatch;

  const EventMatchScreen({
    super.key,
    required this.eventMatch,
  });

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

    String link = validChannelStream.first.channelUrl!;
    cubit = ChannelPlayerCubit(link);
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
      backgroundColor: MainColors.black,
      body: BlocBuilder<ChannelPlayerCubit, ChannelPlayerState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is ChannelPlayerInitializing) {
            return const LoadingWidget();
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
            String? error = state.error;

            return ew.ErrorWidget(error: error ?? L10n.error);
          }
        },
      ),
    );
  }
}
