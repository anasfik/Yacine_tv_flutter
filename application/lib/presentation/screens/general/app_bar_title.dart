import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      title,
      maxLines: 1,
    );
  }
}
