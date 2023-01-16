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
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(0.65),
          iconSize: 27.5,
          selectedFontSize: 11.5,
          unselectedFontSize: 11,
          
          type: BottomNavigationBarType.fixed,
          onTap: (itemIndex) {
            bloc.selectScreenAt(itemIndex);
          },
          currentIndex: state,
          items: bloc.items.map(
            (item) {
              return BottomNavigationBarItem(
                icon: Container(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Icon(item.icon)),
                label: item.name,
              );
            },
          ).toList(),
        );
      },
    );
  }
}
