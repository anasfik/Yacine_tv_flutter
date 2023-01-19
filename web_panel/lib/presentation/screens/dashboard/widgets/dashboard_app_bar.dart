import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_panel/core/extension/context.dart';
import 'package:web_panel/data/providers/l10n/en.dart';

import '../../../../buisness_logic/dashbord_cubit/dashboard_cubit.dart';
import '../../../../buisness_logic/login_bloc/login_bloc_bloc.dart';

class DashBoardAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const DashBoardAppBar({
    super.key,
    this.height = 70,
  });
  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DashBoardScreensCubit>();

    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: height,
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      actions: <Widget>[
        const SizedBox(
          width: 7.5,
        ),
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () async {
            bloc.triggerSettingsScreen(Scaffold.of(context));
          },
        ),
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            context.read<LoginBloc>().add(
              LogoutButtonPressed(
                onSuccess: () {
                  context.snackBarText(L10n.logoutSuccess);
                },
              ),
            );
          },
        ),
      ],
      title: const Text(L10n.dashBoard),
    );
  }
}
