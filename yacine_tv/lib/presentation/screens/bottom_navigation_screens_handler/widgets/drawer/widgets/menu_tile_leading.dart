import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MenuTileLeading extends StatelessWidget {
  const MenuTileLeading({
    super.key,
    required this.icon,
    this.iconWidth = 30,
  });

  final String icon;
  final double iconWidth;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: icon,
      width: iconWidth,
      height: iconWidth,
      fadeInDuration: const Duration(milliseconds: 100),
      errorWidget: (context, url, error) {
        return const Icon(
          Icons.link,
          color: Colors.white,
        );
      },
    );
  }
}
