import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../buisness_logic/dashbord_cubit/dashboard_cubit.dart';
import '../../../../data/providers/l10n/en.dart';
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
                height: 24,
              ),
              ...List.generate(
                cubit.panels.length,
                (index) {
                  final current = cubit.panels[index];
                  return ListTile(
                    selected: index == state,
                    selectedColor: Theme.of(context).primaryColor,
                    leading: Icon(current.icon),
                    title: Text(current.title,
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
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
