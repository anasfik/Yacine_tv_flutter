import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/channel.dart';
import '../../general/margined_body.dart';
import 'channel_screen.dart';

class ChannelCard extends StatelessWidget {
  const ChannelCard({
    super.key,
    required this.channel,
  });

  final Channel channel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => ChannelScreen(
            channel: channel,
          ),
        ));
      },
      child: Card(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            MarginedBody(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CachedNetworkImage(
                imageUrl:
                    "${channel.channelImage}?a=${DateTime.now().millisecondsSinceEpoch}",
                height: 50,
                width: double.infinity,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: Container(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 1.5,
                      value: downloadProgress.progress,
                    ),
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
