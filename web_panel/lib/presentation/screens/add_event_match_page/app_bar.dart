import 'package:flutter/material.dart';

class AEMAppBar extends StatelessWidget with PreferredSizeWidget {
  const AEMAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      title: const Text("Add Event Match"),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
