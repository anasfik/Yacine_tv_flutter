import 'package:flutter/material.dart';

class DSAppBar extends StatelessWidget with PreferredSizeWidget {
  const DSAppBar({
    super.key,
    required this.title,
    this.height = 70,
    this.actions,
  });

  final String title;
  final double height;
final List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: height,
      title: Text(title),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
