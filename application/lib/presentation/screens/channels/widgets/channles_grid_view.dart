import 'package:flutter/material.dart';

import '../../../../data/models/channel.dart';
import 'channel_card.dart';

class ChannelsGridView extends StatelessWidget {
  const ChannelsGridView({
    super.key,
    required this.channels,
  });

  final List<Channel> channels;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: 10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.9,
        crossAxisCount: 3,
        crossAxisSpacing: 7.5,
        mainAxisSpacing: 7.5,
      ),
      itemCount: channels.length,
      itemBuilder: (BuildContext context, int index) {
        Channel current = channels[index];

        return ChannelCard(
          channel: current,
        );
      },
    );
  }
}
