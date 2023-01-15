import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_panel/presentation/screens/general/logo.dart';

import '../../../../buisness_logic/dashbord_cubit/dashboard_cubit.dart';
import '../../general/author_credits.dart';

class DashBoardDrawer extends StatelessWidget {
  const DashBoardDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DashBoardScreensCubit>();
    return Drawer(
      child: BlocBuilder<DashBoardScreensCubit, int>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 40,
              ),
              const Center(
                child: Logo(),
              ),
              const SizedBox(
                height: 40,
              ),
              ...List.generate(
                cubit.panels.length,
                (index) {
                  final current = cubit.panels[index];
                  return ListTile(
                    selectedTileColor:
                        Theme.of(context).primaryColor.withOpacity(0.1),
                    selected: index == state,
                    leading: Icon(
                      current.icon,
                      color: index == state
                          ? Theme.of(context).primaryColor
                          : null,
                    ),
                    title: Text(current.title,
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                              color: index == state
                                  ? Theme.of(context).primaryColor
                                  : null,
                              fontWeight: FontWeight.w500,
                            )),
                    onTap: () {
                      cubit.triggerScreenAt(index);
                    },
                  );
                },
              ),
              const Spacer(),
              const AuthorCredits(),
              const SizedBox(
                height: 24,
              )
            ],
          );
        },
      ),
    );
  }
}
