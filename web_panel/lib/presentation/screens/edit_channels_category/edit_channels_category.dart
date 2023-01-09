import 'package:flutter/material.dart';

import '../../../data/models/chennels_category.dart';
import '../add_screen/add_channel.dart';
import '../general/action_button.dart';
import '../general/channel_card.dart';

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
        ],
      ),
    );
  }
}
