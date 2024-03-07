import 'package:flutter/material.dart';

class ACAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ACAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 140,
      title: const Text('Add Channel'),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(140);
}
