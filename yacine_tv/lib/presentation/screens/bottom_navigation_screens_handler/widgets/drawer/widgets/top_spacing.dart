import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/general.dart';
import '../../../../../../logic/settings_cubit/settings_cubit.dart';

class Cover extends StatelessWidget {
  const Cover({
    super.key,
    this.spacing = 22.5,
    this.height = 75,
    this.width = 175,
  });

  final double spacing;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SettingsCubit>().state.settings;
    print(bloc?.appLogoCover);

    return Container(
      margin: EdgeInsets.only(
        top: spacing + MediaQuery.of(context).padding.top,
        bottom: spacing,
      ),
      child: CachedNetworkImage(
        imageUrl: bloc?.appLogoCover ??
            Configs.menuImageCoverToShowWhenOriginalOneFails,
        errorWidget: (BuildContext context, String url, dynamic error) {
          return Image.asset(
            Configs.menuImageCoverToShowWhenOriginalOneFails,
            width: width,
            height: height,
          );
        },
        width: width,
        height: height,
      ),
    );
  }
}
