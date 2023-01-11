import 'package:flutter/material.dart';

class AAppBar extends StatelessWidget with PreferredSizeWidget {
  const AAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      title: const Text("Administration"),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
