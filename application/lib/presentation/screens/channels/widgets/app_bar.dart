import 'package:flutter/material.dart';
import 'package:yacine_tv/presentation/screens/general/app_bar_title.dart';

import '../../../../data/models/channel.dart';
import 'channels_search_delegate.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar(
    this.title, {
    super.key,
    required this.channels,
  });

  final String title;
  final List<Channel> channels;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: kToolbarHeight,
      title: AppBarTitle(title: title),
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
