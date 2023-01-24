import 'package:flutter/material.dart';
import 'package:yacine_tv/core/extensions/context.dart';

import '../../../../../../core/core.dart';
import '../../../../../../core/lang/en.dart';
import 'menu_tile_title.dart';

class ShareItem extends StatelessWidget {
  const ShareItem({super.key});

  @override
  Widget build(BuildContext context) {
    const iconWidth = 30.0;

    return ListTile(
      minLeadingWidth: iconWidth,
      leading: const Icon(
        Icons.share,
        color: Colors.white,
      ),
      title: MenuTileTitle(
        title: "Share",
      ),
      onTap: () {
        Core.shareApp(
          onError: (error) {
            context.snackBarText(L10n.error);
          },
        );
      },
    );
  }
}
