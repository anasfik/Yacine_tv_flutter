import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:web_panel/data/models/chennels_category.dart';
import 'package:web_panel/presentation/config/colors/colors.dart';

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
    return Material(
      color: AppColors.white,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: 300,
          height: 75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: 3,
            ),
          ),
          child: Center(
            child: AutoSizeText(
              category.categoryTitle,
              style: Theme.of(context).textTheme.headline5?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
              maxLines: 1,
            ),
          ),
        ),
      ),
    );
  }
}
