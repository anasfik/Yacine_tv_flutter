import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:yacine_tv/presentation/screens/channels/widgets/channles_grid_view.dart';

import '../../../../core/core.dart';
import '../../../../data/models/channel.dart';
import 'channels_search_delegate.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;

  final List<Channel> channels;
  const CustomAppBar(
    this.title, {
    super.key,
    required this.channels,
  });
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: kToolbarHeight,
      title: AutoSizeText(title),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            showSearch(
              context: context,
              delegate: ChannelsSearchDelegate(channels),
            );
          },
        ),
      ],
    );
  }
}
