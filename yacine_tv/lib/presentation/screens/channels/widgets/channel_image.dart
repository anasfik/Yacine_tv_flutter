import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../general/margined_body.dart';

class ChannelImage extends StatelessWidget {
  const ChannelImage({
    super.key,
    required this.channelImage,
  });

  final String channelImage;
  @override
  Widget build(BuildContext context) {
    return MarginedBody(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: CachedNetworkImage(
        imageUrl: channelImage,
        height: 50,
        width: double.infinity,
        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
          child: SizedBox(
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
    );
  }
}
