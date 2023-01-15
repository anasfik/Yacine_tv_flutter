import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:web_panel/data/providers/l10n/en.dart';

import '../../config/colors/colors.dart';
import 'action_button.dart';

class ScreenTitle extends StatelessWidget {
  const ScreenTitle({
    required this.title,
    this.onAddButtonPressed,
    super.key,
    this.showAddButton = true,
    this.addButtonText = L10n.add,
  });

  final String title;
  final String addButtonText;

  final void Function()? onAddButtonPressed;
  final bool showAddButton;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style: Theme.of(context).textTheme.headline4?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
        ),
        if (showAddButton)
          ActionButton(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 30,
            ),
            text: addButtonText,
            icon: const Icon(
              FlutterRemix.add_line,
              size: 18,
            ),
            onPressed: onAddButtonPressed ?? () {},
          ),
      ],
    );
  }
}
