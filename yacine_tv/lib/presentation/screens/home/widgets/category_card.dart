import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/channels_category.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.category,
    required this.onPressed,
  });

  final ChannelsCategory category;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: 300,
          height: 75,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              color: theme.primaryColor,
              width: 3,
            ),
          ),
          child: Center(
            child: AutoSizeText(
              category.categoryTitle,
              style: theme.textTheme.headline5?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.primaryColor,
              ),
              maxLines: 1,
            ),
          ),
        ),
      ),
    );
  }
}
