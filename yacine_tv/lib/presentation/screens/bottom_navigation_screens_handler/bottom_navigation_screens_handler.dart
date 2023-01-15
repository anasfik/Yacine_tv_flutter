import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transitioned_indexed_stack/transitioned_indexed_stack.dart';
import 'package:yacine_tv/logic/bottom_navigation/bottom_navigation_cubit.dart';

import 'widgets/app_bar.dart';
import 'widgets/bottom_navigation_bar.dart';
import 'widgets/drawer.dart';

class ScreensHandler extends StatelessWidget {
  const ScreensHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: const CustomAppBar(),
      bottomNavigationBar: const CustomNavigationBar(),
      body: BlocBuilder<BottomNavigationCubit, int>(
        builder: (_, state) {
          return FadeIndexedStack(
            beginOpacity: 0.0,
            endOpacity: 1.0,
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 100),
            index: state,
            children: context.read<BottomNavigationCubit>().items.map(
              (item) {
                return item.screen;
              },
            ).toList(),
          );
        },
      ),
    );
  }
}
