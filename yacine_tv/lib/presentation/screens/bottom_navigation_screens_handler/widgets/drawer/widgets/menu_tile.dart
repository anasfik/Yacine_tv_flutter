import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yacine_tv/core/extensions/context.dart';
import 'package:yacine_tv/data/models/menu_item.dart' as mi;
import 'package:yacine_tv/presentation/screens/bottom_navigation_screens_handler/widgets/drawer/widgets/menu_tile_title.dart';

import '../../../../../../core/lang/en.dart';
import '../../../../../../logic/drawer_cubit/drawer_cubit_cubit.dart';
import 'menu_tile_leading.dart';

class MenuTile extends StatelessWidget {
  final mi.MenuItem item;

  const MenuTile({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    const iconWidth = 30.0;

    return ListTile(
      minLeadingWidth: iconWidth,
      leading: MenuTileLeading(
        icon: item.icon,
      ),
      title: MenuTileTitle(
        title: item.title,
      ),
      onTap: () {
        context.read<DrawerCubit>().openLink(
          item.link,
          onError: (error) {
            context.snackBarText(L10n.error);
          },
        );
      },
    );
  }
}
