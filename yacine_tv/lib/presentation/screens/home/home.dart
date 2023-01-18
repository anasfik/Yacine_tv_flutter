import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yacine_tv/core/extensions/context.dart';
import 'package:yacine_tv/core/lang/en.dart';
import 'package:yacine_tv/data/models/channels_category.dart';
import 'package:yacine_tv/presentation/config/colors.dart';
import 'package:yacine_tv/presentation/screens/general/emptiness.dart';
import 'package:yacine_tv/presentation/screens/general/loading.dart';
import 'package:yacine_tv/presentation/screens/home/widgets/category_card.dart';
import '../../../logic/channels_categories_cubit/channels_categories_cubit.dart';
import '../channels/channels.dart';
import '../general/margined_body.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    ChannelsCategoriesCubit cubit = context.read<ChannelsCategoriesCubit>();

    return Scaffold(
      backgroundColor: MainColors.transparent,
      body: BlocBuilder<ChannelsCategoriesCubit, ChannelsCategoriesState>(
        builder: (context, state) {
          if (state is ChannelsCategoriesLoading) {
            return const LoadingWidget();
          } else if (state is ChannelsCategoriesLoaded) {
            List<ChannelsCategory> channelsCategories =
                state.channelsCategories ?? [];

            if (channelsCategories.isEmpty) {
              return const EmptinessWidget();
            }

            return MarginedBody(
              child: RefreshIndicator(
                onRefresh: () {
                  return cubit.loadChannelsCategories();
                },
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: channelsCategories.length,
                      itemBuilder: (BuildContext context, int index) {
                        ChannelsCategory current = channelsCategories[index];

                        return CategoryCard(
                          onPressed: () {
                            context.navigatorPush(Channels(category: current));
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
            return ErrorWidget(
              state.error ?? L10n.error,
            );
          }
        },
      ),
    );
  }
}
