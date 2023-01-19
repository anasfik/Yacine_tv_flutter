import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_panel/buisness_logic/dashbord_cubit/dashboard_cubit.dart';
import 'package:web_panel/presentation/screens/dashboard/widgets/dashboard_drawer.dart';

import '../../config/colors/colors.dart';
import 'widgets/dashboard_app_bar.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    DashBoardScreensCubit cubit = context.read<DashBoardScreensCubit>();

    return Scaffold(
      backgroundColor: AppColors.white,
      drawer: const DashBoardDrawer(),
      appBar: const DashBoardAppBar(),
      body: BlocBuilder<DashBoardScreensCubit, int>(
        builder: (BuildContext context, int state) {
          return cubit.panels[state].screen;
        },
      ),
    );
  }
}
