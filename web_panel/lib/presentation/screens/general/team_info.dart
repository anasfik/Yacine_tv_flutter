import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:web_panel/core/extension/string.dart';

class TeamInfo extends StatelessWidget {
  const TeamInfo({
    super.key,
    required this.name,
    required this.logoUrl,
  });

  final String name;
  final String logoUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CachedNetworkImage(
          imageUrl: logoUrl,
          width: 70,
          height: 70,
        ),
        const SizedBox(
          height: 10,
        ),
        AutoSizeText(
          name.capitalizeAllWordsFirstLetter(),
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ],
    );
  }
}
