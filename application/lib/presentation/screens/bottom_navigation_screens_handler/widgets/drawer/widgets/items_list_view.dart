import 'package:flutter/material.dart';
import 'package:yacine_tv/data/models/menu_item.dart' as mi;
import 'package:yacine_tv/presentation/screens/bottom_navigation_screens_handler/widgets/drawer/widgets/menu_tile.dart';
import 'package:yacine_tv/presentation/screens/bottom_navigation_screens_handler/widgets/drawer/widgets/top_spacing.dart';

import '../../../../general/divider.dart';

class ItemsListView extends StatelessWidget {
  const ItemsListView({
    super.key,
    required this.drawerItems,
  });

  final List<mi.MenuItem> drawerItems;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const Cover(),
          const DividerWidget(),
          // ignore: avoid-shrink-wrap-in-lists
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: drawerItems.length,
            itemBuilder: (BuildContext context, int index) {
              mi.MenuItem current = drawerItems[index];

              return MenuTile(
                item: current,
              );
            },
          ),
        ],
      ),
    );
  }
}
