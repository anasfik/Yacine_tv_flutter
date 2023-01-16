import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yacine_tv/core/lang/en.dart';
import 'package:yacine_tv/presentation/screens/home/widgets/category_card.dart';
import '../../../logic/channels_categories_cubit/channels_categories_cubit.dart';
import '../channels/channels.dart';
import '../general/margined_body.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocBuilder<ChannelsCategoriesCubit, ChannelsCategoriesState>(
        builder: (context, state) {
          if (state is ChannelsCategoriesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ChannelsCategoriesLoaded) {
            final channelsCategories = state.channelsCategories!;
            if (channelsCategories.isEmpty) {
              return const Center(
                child: Text(L10n.noChannelsCategoriesFound),
              );
            }

            return MarginedBody(
              child: RefreshIndicator(
                onRefresh: () {
                  return context
                      .read<ChannelsCategoriesCubit>()
                      .loadChannelsCategories();
                },
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: channelsCategories.length,
                      itemBuilder: (_, int index) {
                        final current = channelsCategories[index];

                        return CategoryCard(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return Channels(
                                    category: current,
                                  );
                                },
                              ),
                            );
                          },
                          category: current,
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: Text(state.error ?? L10n.error));
          }
        },
      ),
    );
  }
}
