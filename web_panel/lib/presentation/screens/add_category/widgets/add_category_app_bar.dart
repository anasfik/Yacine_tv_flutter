import 'package:flutter/material.dart';

class ADAppBar extends StatelessWidget with PreferredSizeWidget {
  const ADAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 140,
      title: const Text("Add Category"),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(140);
}
