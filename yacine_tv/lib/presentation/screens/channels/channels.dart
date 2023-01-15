import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yacine_tv/data/models/channels_category.dart';
import 'package:yacine_tv/presentation/screens/general/margined_body.dart';

import '../../../data/models/channel.dart';
import 'widgets/app_bar.dart';

class Channels extends StatelessWidget {
  const Channels({
    super.key,
    required this.category,
  });

  final ChannelsCategory category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(category.categoryTitle),
      body: MarginedBody(
        child: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(scrollbars: false),
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              // childAspectRatio: 1.5,
            ),
            itemCount: category.channels.length,
            itemBuilder: (_, int index) {
              final Channel current = category.channels[index];

              return Card(
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    MarginedBody(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: CachedNetworkImage(
                        imageUrl: current.channelImage,
                        height: 50,
                        width: double.infinity,
                        // fit: BoxFit.fill,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                          value: downloadProgress.progress,
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
                      child: Text(current.channelName),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
