import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yacine_tv/core/extensions/string.dart';

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
    return SizedBox(
      width: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: logoUrl,
            width: 80,
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
      ),
    );
  }
}
