import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yacine_tv/core/extensions/context.dart';

import '../../../../data/models/channel.dart';
import '../../general/margined_body.dart';
import 'channel_image.dart';
import 'channel_screen.dart';

class ChannelCard extends StatelessWidget {
  const ChannelCard({
    super.key,
    required this.channel,
  });

  final Channel channel;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          context.navigatorPush(ChannelScreen(channel: channel));
        },
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            ChannelImage(
              channelImage: channel.channelImage,
            ),
            const Spacer(),
            Center(
              child: AutoSizeText(
                channel.channelName,
                maxLines: 1,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
