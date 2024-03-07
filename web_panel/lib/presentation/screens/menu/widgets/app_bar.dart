import 'package:flutter/material.dart';

class MAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      title: const Text("Menu"),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
