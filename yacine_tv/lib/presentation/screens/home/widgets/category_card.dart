import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:yacine_tv/presentation/config/colors.dart';

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
    ThemeData theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: MainColors.white,
        child: InkWell(
          onTap: onPressed,
          child: Container(
            width: double.infinity,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.fromBorderSide(
                BorderSide(color: theme.primaryColor, width: 3),
              ),
            ),
            child: Center(
              child: AutoSizeText(
                category.categoryTitle,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColor,
                ),
                maxLines: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
