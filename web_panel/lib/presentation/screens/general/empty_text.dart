import 'package:flutter/material.dart';

import '../../config/colors/colors.dart';

class EmptyText extends StatelessWidget {
  const EmptyText(
    this.text, {
    super.key,
    this.height = 500,
  });

  final double height;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 500,
        height: height,
        child: Center(
          child: Text(
            textAlign: TextAlign.center,
            text,
            style: Theme.of(context).textTheme.headline6?.copyWith(
                  color: AppColors.black.withOpacity(0.75),
                ),
          ),
        ),
      ),
    );
  }
}
