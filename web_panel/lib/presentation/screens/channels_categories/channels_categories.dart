import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_panel/core/extension/context.dart';
import 'package:web_panel/data/models/chennels_category.dart';
import 'package:web_panel/data/providers/l10n/en.dart';
import 'package:web_panel/presentation/screens/general/loading_widget.dart';
import 'package:web_panel/presentation/screens/general/screen_title.dart';

import '../../../buisness_logic/channels_categories_bloc/channels_categories_bloc.dart';
import '../add_category/add_vategory.dart';
import '../edit_channels_category/edit_channels_category.dart';
import '../general/category_card.dart';
import '../general/empty_text.dart';
import '../general/margined_body.dart';

class ChannelsCategories extends StatelessWidget {
  final String title;

  const ChannelsCategories({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    ChannelsCategoriesBloc bloc = context.read<ChannelsCategoriesBloc>();

    return MarginedBody(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ScreenTitle(
              title: title,
              addButtonText: L10n.newCategory,
              onAddButtonPressed: () {
                context.push(const AddChannelCategory());
              },
            ),
            BlocBuilder<ChannelsCategoriesBloc, ChannelsCategoriesState>(
              builder: (BuildContext context, ChannelsCategoriesState state) {
                return state.isLoading
                    ? const LoadingWidget()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          AutoSizeText(
                            bloc.channelsCategoriesLength(),
                          ),
                          const SizedBox(height: 20),
                          Builder(
                            builder: (context) {
                              if (state.allChannelsCategories.isEmpty) {
                                return const EmptyText(
                                  L10n.noChannelsCategories,
                                );
                              }

                              return Center(
                                child: Wrap(
                                  spacing: 20,
                                  runSpacing: 20,
                                  children: List.generate(
                                    state.allChannelsCategories.length,
                                    (index) {
                                      ChannelsCategory current =
                                          state.allChannelsCategories[index];

                                      return CategoryCard(
                                        category: current,
                                        onPressed: () {
                                          context.push(
                                            EditChannelsCategory(
                                              category: current,
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
