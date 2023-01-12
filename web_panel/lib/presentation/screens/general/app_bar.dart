import 'package:flutter/material.dart';

class DSAppBar extends StatelessWidget with PreferredSizeWidget {
  const DSAppBar({
    super.key,
    required this.title,
    this.height = 70,
  });

  final String title;
  final double height;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: height,
      title: Text(title),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
