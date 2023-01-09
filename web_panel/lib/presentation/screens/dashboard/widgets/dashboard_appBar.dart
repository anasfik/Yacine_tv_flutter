import 'package:flutter/material.dart';

import '../../general/logo.dart';

class DashBoardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DashBoardAppBar({super.key, this.height = 80});

  final double height;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: height,
      centerTitle: true,
      title: Container(
        child: Logo(),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
