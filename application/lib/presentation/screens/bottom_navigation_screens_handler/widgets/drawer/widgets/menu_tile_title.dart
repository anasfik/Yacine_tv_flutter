import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:yacine_tv/presentation/config/colors.dart';

class MenuTileTitle extends StatelessWidget {
  const MenuTileTitle({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      title,
      maxLines: 1,
      style: Theme.of(context).textTheme.bodyText1?.copyWith(
            color: MainColors.white,
          ),
    );
  }
}
