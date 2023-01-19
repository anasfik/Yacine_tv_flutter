import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_panel/data/models/dashboard_screen.dart';
import 'package:web_panel/presentation/screens/dashboard/widgets/dashboard_tile.dart';

import '../../../../buisness_logic/dashbord_cubit/dashboard_cubit.dart';
import '../../general/author_credits.dart';

class DashBoardDrawer extends StatelessWidget {
  const DashBoardDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    DashBoardScreensCubit cubit = context.read<DashBoardScreensCubit>();

    return Drawer(
      child: BlocBuilder<DashBoardScreensCubit, int>(
        builder: (BuildContext context, int state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 40),
              const SizedBox(height: 40),
              ...List.generate(
                cubit.panels.length,
                (index) {
                  DashBoardScreen current = cubit.panels[index];

                  return DashBoardTile(
                    dashBoardScreen: current,
                    index: index,
                    state: state,
                    onTap: () {
                      cubit.triggerScreenAt(index);
                    },
                  );
                },
              ),
              const Spacer(),
              const AuthorCredits(),
              const SizedBox(height: 24),
            ],
          );
        },
      ),
    );
  }
}
