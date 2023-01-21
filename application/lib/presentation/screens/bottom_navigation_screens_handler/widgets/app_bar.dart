import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yacine_tv/core/lang/en.dart';
import 'package:yacine_tv/presentation/screens/general/app_bar_title.dart';
import 'package:yacine_tv/presentation/screens/home/widgets/search_delegate.dart';

import '../../../../data/models/channels_category.dart';
import '../../../../logic/channels_categories_cubit/channels_categories_cubit.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ChannelsCategoriesCubit, ChannelsCategoriesState,
        List<ChannelsCategory>?>(
      selector: (state) {
        return state.channelsCategories;
      },
      builder: (context, state) {
        List<ChannelsCategory> allCategories = state ?? <ChannelsCategory>[];

        return AppBar(
          toolbarHeight: kToolbarHeight,
          centerTitle: true,
          title: const AppBarTitle(
            title: L10n.title,
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(
                    allCategories: allCategories,
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
