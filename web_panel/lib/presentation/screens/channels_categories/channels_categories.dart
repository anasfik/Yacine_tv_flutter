import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:web_panel/data/models/chennels_category.dart';
import 'package:web_panel/presentation/screens/general/action_button.dart';

import '../../../buisness_logic/channels_categories_bloc/channels_categories_bloc.dart';
import '../../config/colors/colors.dart';
import '../add_category/add_vategory.dart';
import '../general/category_card.dart';
import '../general/margined_body.dart';

class ChannelsCategories extends StatelessWidget {
  const ChannelsCategories({
    super.key,
    required this.title,
  });

  final String title;
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ChannelsCategoriesBloc>();
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                ),
                Row(
                  children: <Widget>[
                    ActionButton(
                      icon: const Icon(
                        FlutterRemix.add_line,
                        size: 18,
                      ),
                      height: 30,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddChannelCategory(),
                          ),
                        );
                      },
                      text: "Add",
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 10),
            FutureBuilder<List<ChannelsCategory>>(
              future: bloc.all(),
              builder: (_, AsyncSnapshot<List<ChannelsCategory>> snapshot) {
                if (snapshot.hasData) {
                  List<ChannelsCategory> data = snapshot.data!;
                  ChannelsCategory example1 = data[0];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AutoSizeText(
                        "${data.length} categories",
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Wrap(
                          spacing: 20,
                          runSpacing: 20,
                          children: List.generate(
                            10,
                            (index) {
                              return CategoryCard(category: example1);
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
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
