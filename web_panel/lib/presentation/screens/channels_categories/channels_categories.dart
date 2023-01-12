import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:web_panel/data/providers/l10n/en.dart';
import 'package:web_panel/presentation/screens/general/action_button.dart';
import 'package:web_panel/presentation/screens/general/screen_title.dart';
import '../../../buisness_logic/channels_categories_bloc/channels_categories_bloc.dart';
import '../../config/colors/colors.dart';
import '../add_category/add_vategory.dart';
import '../edit_channels_category/edit_channels_category.dart';
import '../general/category_card.dart';
import '../general/empty_text.dart';
import '../general/margined_body.dart';

class ChannelsCategories extends StatelessWidget {
  const ChannelsCategories({
    super.key,
    required this.title,
  });

  final String title;
  @override
  Widget build(BuildContext context) {
    return MarginedBody(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 20,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ScreenTitle(
              title: title,
              addButtonText: L10n.newCategory,
              onAddButtonPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddChannelCategory(),
                  ),
                );
              },
            ),
            BlocBuilder<ChannelsCategoriesBloc, ChannelsCategoriesState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AutoSizeText(
                        "${state.allChannelsCategories.length} categories",
                      ),
                      const SizedBox(height: 20),
                      Builder(builder: (context) {
                        if (state.allChannelsCategories.isEmpty) {
                          return const EmptyText(L10n.noChannelsCategories);
                        }
                        return Center(
                          child: Wrap(
                            spacing: 20,
                            runSpacing: 20,
                            children: List.generate(
                              state.allChannelsCategories.length,
                              (index) {
                                return CategoryCard(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EditChannelsCategory(
                                          category: state
                                              .allChannelsCategories[index],
                                        ),
                                      ),
                                    );
                                  },
                                  category: state.allChannelsCategories[index],
                                );
                              },
                            ),
                          ),
                        );
                      }),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
