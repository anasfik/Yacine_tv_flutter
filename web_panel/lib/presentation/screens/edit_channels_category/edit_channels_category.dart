import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_panel/buisness_logic/channels_categories_bloc/channels_categories_bloc.dart';

import '../../../data/models/channel.dart';
import '../../../data/models/chennels_category.dart';
import '../add_channel/add_channel.dart';
import '../general/action_button.dart';
import '../general/channel_card.dart';
import '../update_channels_category/UpdateChannelsCategory.dart';

class EditChannelsCategory extends StatelessWidget {
  const EditChannelsCategory({
    super.key,
    required this.category,
  });

  final ChannelsCategory category;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.categoryTitle),
      ),
      body: Column(
        children: <Widget>[
          ...List.generate(
            category.channels.length,
            (index) => ChannelCard(
              categoryId: category.id,
              channel: category.channels[index],
            ),
          ),
          ActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddChannel(
                    channel: Channel.empty(),
                    categoryId: category.id,
                  ),
                ),
              );
            },
            text: 'add',
          ),
          ActionButton(
            onPressed: () {
              context.read<ChannelsCategoriesBloc>().add(
                    DeleteCategory(
                      categoryId: category.id,
                      onSuccess: () {
                        context
                            .read<ChannelsCategoriesBloc>()
                            .add(NewCategoriesGetRequested());
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Category deleted'),
                          ),
                        );
                        Navigator.of(context).pop();
                      },
                      onError: (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(error),
                          ),
                        );
                      },
                    ),
                  );
            },
            text: 'delete',
          ),
          ActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateChannelsCategory(
                    categoryId: category.id,
                  ),
                ),
              );
            },
            text: 'update',
          ),
        ],
      ),
    );
  }
}
