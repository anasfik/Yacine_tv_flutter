import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yacine_tv/logic/bottom_navigation/bottom_navigation_cubit.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BottomNavigationCubit>();

    return BlocBuilder<BottomNavigationCubit, int>(
      builder: (context, state) {
        return BottomNavigationBar(
          onTap: (itemIndex) {
            bloc.selectScreenAt(itemIndex);
          },
          currentIndex: state,
          items: bloc.items.map(
            (item) {
              return BottomNavigationBarItem(
                icon: Icon(item.icon),
                label: item.name,
              );
            },
          ).toList(),
        );
      },
    );
  }
}
