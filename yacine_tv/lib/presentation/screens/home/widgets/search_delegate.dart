import 'package:flutter/material.dart';
import 'package:yacine_tv/data/models/channels_category.dart';
import 'package:yacine_tv/presentation/screens/channels/widgets/channles_grid_view.dart';

import '../../../../core/core.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<ChannelsCategory> allCategories;

  CustomSearchDelegate({
    required this.allCategories,
  });

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
    final filteredChannels = Core.customCategoriesChannelsSearch(
      allCategories,
      searchQuery: query,
    );

    return ChannelsGridView(
      channels: filteredChannels.toList(),
    );
  }
}
