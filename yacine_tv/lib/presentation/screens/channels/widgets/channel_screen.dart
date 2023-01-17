import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_viewer/video_viewer.dart';
import 'package:yacine_tv/core/lang/en.dart';

import '../../../../core/core.dart';
import '../../../../data/models/channel.dart';
import '../../../../logic/channel_player/channel_player_cubit.dart';

class ChannelScreen extends StatefulWidget {
  const ChannelScreen({
    super.key,
    required this.channel,
  });

  final Channel channel;

  @override
  State<ChannelScreen> createState() => _ChannelScreenState();
}

class _ChannelScreenState extends State<ChannelScreen> {
  late ChannelPlayerCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = ChannelPlayerCubit();

    Core.setLandscape();
  }

  @override
  void dispose() {
    super.dispose();
    Core.setPortrait();
    cubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<ChannelPlayerCubit, ChannelPlayerState>(
        bloc: cubit,
        builder: (context, state) {
          // ignore: prefer-conditional-expressions
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
              ],
            );
          } else {
            final error = state.error;

            return const Center(child: Text(L10n.error));
          }
        },
      ),
    );
  }
}
