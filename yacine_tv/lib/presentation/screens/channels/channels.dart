import 'package:flutter/material.dart';
import 'package:yacine_tv/data/models/channels_category.dart';
import 'package:yacine_tv/presentation/config/colors.dart';
import 'package:yacine_tv/presentation/screens/channels/widgets/channles_grid_view.dart';
import 'package:yacine_tv/presentation/screens/general/margined_body.dart';
import 'package:yacine_tv/presentation/screens/general/screen_background.dart';

import 'widgets/app_bar.dart';

class Channels extends StatelessWidget {
  const Channels({
    super.key,
    required this.category,
  });

  final ChannelsCategory category;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        const ScreenBackground(),
        Scaffold(
          backgroundColor: MainColors.transparent,
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
