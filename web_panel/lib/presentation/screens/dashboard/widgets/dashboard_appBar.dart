import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../buisness_logic/dashbord_cubit/dashboard_cubit.dart';
import '../../../../buisness_logic/login_bloc/login_bloc_bloc.dart';
import '../../general/logo.dart';

class DashBoardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DashBoardAppBar({super.key, this.height = 70});

  final double height;
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DashBoardScreensCubit>();

    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: height,
      // centerTitle: true,
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
              bloc.triggerSettingsScreen(context);
            }),
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            context.read<LoginBloc>().add(
              LogoutButtonPressed(
                onSuccess: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Logged out successfully'),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
      title: Text("Dashboard"),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
