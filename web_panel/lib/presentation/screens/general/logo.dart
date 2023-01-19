import 'package:flutter/material.dart';

class Cover extends StatelessWidget {
  const Cover({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.network("https://via.placeholder.com/100x50"),
    );
  }
}
