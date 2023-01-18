import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yacine_tv/presentation/screens/bottom_navigation_screens_handler/widgets/drawer/widgets/items_list_view.dart';
import 'package:yacine_tv/presentation/screens/general/loading.dart';

import '../../../../../logic/drawer_cubit/drawer_cubit_cubit.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).primaryColor,
      child: BlocBuilder<DrawerCubit, DrawerState>(
        builder: (BuildContext context, DrawerState state) {
          if (state is DrawerStateLoading) {
            return const LoadingWidget();
          } else if (state is DrawerStateLoaded) {
            return ItemsListView(drawerItems: state.drawerItems ?? []);
          } else {
            return ErrorWidget(state.error ?? '');
          }
        },
      ),
    );
  }
}
