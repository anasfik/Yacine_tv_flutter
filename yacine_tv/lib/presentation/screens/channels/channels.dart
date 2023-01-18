import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yacine_tv/data/models/channels_category.dart';
import 'package:yacine_tv/presentation/screens/channels/widgets/channles_grid_view.dart';
import 'package:yacine_tv/presentation/screens/general/margined_body.dart';

import '../../../data/models/channel.dart';
import 'widgets/app_bar.dart';
import 'widgets/channel_card.dart';

class Channels extends StatelessWidget {
  final ChannelsCategory category;

  const Channels({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          "assets/background.jpg",
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: CustomAppBar(
            category.categoryTitle,
            channels: category.channels,
          ),
          body: MarginedBody(
            child: ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(scrollbars: false),
              child: ChannelsGridView(
                channels: category.channels,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
