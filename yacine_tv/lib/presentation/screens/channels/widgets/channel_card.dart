import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/channel.dart';
import '../../general/margined_body.dart';

class ChannelCard extends StatelessWidget {
  const ChannelCard({
    super.key,
    required this.channel,
  });

  final Channel channel;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          MarginedBody(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CachedNetworkImage(
              imageUrl:
                  "${channel.channelImage}?a=${DateTime.now().microsecondsSinceEpoch}",
              height: 50,
              width: double.infinity,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                child: CircularProgressIndicator(
                  value: downloadProgress.progress,
                ),
              ),
              errorWidget: (context, url, error) {
                return Icon(
                  Icons.error,
                  color: Theme.of(context).primaryColor,
                );
              },
            ),
          ),
          Spacer(),
          Center(
            child: Text(channel.channelName),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
