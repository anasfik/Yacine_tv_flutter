import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.color, this.strokeWidth});

  final Color? color;
  final double? strokeWidth;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color,
        strokeWidth: strokeWidth ?? 4.0,
      ),
    );
  }
}
