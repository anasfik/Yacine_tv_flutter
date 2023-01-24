import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yacine_tv/data/models/menu_item.dart' as mi;
import 'package:yacine_tv/logic/settings_cubit/settings_cubit.dart';
import 'package:yacine_tv/presentation/screens/bottom_navigation_screens_handler/widgets/drawer/widgets/menu_tile.dart';
import 'package:yacine_tv/presentation/screens/bottom_navigation_screens_handler/widgets/drawer/widgets/share_tile.dart';
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
    final bloc = context.read<SettingsCubit>();
    mi.MenuItem privacy = mi.MenuItem(
      id: "_",
      icon: "https://placehold.co/50x50",
      title: "Privacy & Policy",
      link: bloc.state.settings?.appPrivacyPolicy ?? "",
    );
    mi.MenuItem contact = mi.MenuItem(
      id: "_",
      icon: "https://placehold.co/50x50",
      title: "Contact us",
      link: "mailto:${bloc.state.settings?.appEmail}",
    );
    mi.MenuItem website = mi.MenuItem(
      id: "_",
      icon: "https://placehold.co/50x50",
      title: "Website",
      link: bloc.state.settings?.appWebsite ?? "",
    );

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const Cover(),
          const DividerWidget(),
          MenuTile(
            item: contact,
          ),
          MenuTile(
            item: website,
          ),
          ...List.generate(
            drawerItems.length,
            (index) {
              mi.MenuItem current = drawerItems[index];

              return MenuTile(
                item: current,
              );
            },
          ),
          MenuTile(
            item: privacy,
          ),
          ShareItem(),
        ],
      ),
    );
  }
}
