import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../data/models/channel.dart';
import 'channles_grid_view.dart';

class ChannelsSearchDelegate extends SearchDelegate {
  final List<Channel> channels;

  ChannelsSearchDelegate(this.channels);

  @override
  ThemeData appBarTheme(context) {
    final ThemeData theme = Theme.of(context);
    print(theme.appBarTheme.backgroundColor);

    return theme.copyWith(
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.65),
        ),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final filteredChannels =
        Core.customChannelsSearch(channels, searchQuery: query);

    return ChannelsGridView(
      channels: filteredChannels.toList(),
    );
  }
}
