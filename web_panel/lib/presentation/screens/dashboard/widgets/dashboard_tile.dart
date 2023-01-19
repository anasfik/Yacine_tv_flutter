import 'package:flutter/material.dart';

import '../../../../data/models/dashboard_screen.dart';

class DashBoardTile extends StatelessWidget {
  final DashBoardScreen dashBoardScreen;
  final int state;
  final int index;
  final VoidCallback onTap;

  const DashBoardTile({
    super.key,
    required this.dashBoardScreen,
    required this.state,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Color primaryColor = theme.primaryColor;

    return ListTile(
      selectedTileColor: primaryColor.withOpacity(0.1),
      selected: index == state,
      leading: Icon(
        dashBoardScreen.icon,
        color: index == state ? primaryColor : null,
      ),
      title: Text(
        dashBoardScreen.title,
        style: theme.textTheme.subtitle1?.copyWith(
          color: index == state ? primaryColor : null,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}
