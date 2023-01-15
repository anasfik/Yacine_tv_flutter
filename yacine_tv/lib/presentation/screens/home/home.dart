import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/channels_categories_cubit/channels_categories_cubit.dart';
import '../general/margined_body.dart';
import 'widgets/app_bar.dart';
import 'widgets/drawer.dart';

class Home extends StatelessWidget {
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: const CustomAppBar(),
      body: BlocBuilder<ChannelsCategoriesCubit, ChannelsCategoriesState>(
        builder: (context, state) {
          if (state is ChannelsCategoriesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ChannelsCategoriesLoaded) {
            return MarginedBody(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.channelsCategories!.length,
                itemBuilder: (_, int categoryIndex) {
                  return Text("$categoryIndex");
                },
              ),
            );
          } else {
            return Center(child: Text(state.error!));
          }
        },
      ),
    );
  }
}
