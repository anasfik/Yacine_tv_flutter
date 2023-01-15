import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:web_panel/buisness_logic/channels_categories_bloc/channels_categories_bloc.dart';
import 'package:web_panel/presentation/screens/general/app_bar.dart';
import 'package:web_panel/presentation/screens/general/margined_body.dart';
import 'package:web_panel/presentation/screens/general/screen_title.dart';

import '../../../data/models/channel.dart';
import '../../../data/models/chennels_category.dart';
import '../../../data/providers/l10n/en.dart';
import '../add_channel/add_channel.dart';
import '../general/action_button.dart';
import '../general/channel_card.dart';
import '../general/empty_text.dart';
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
      appBar: DSAppBar(
        title: "${category.categoryTitle}'s channels",
        actions: [
          IconButton(
            icon: const Icon(FlutterRemix.edit_fill),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateChannelsCategory(
                    category: category,
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            icon: Icon(FlutterRemix.delete_bin_fill),
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
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: MarginedBody(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ScreenTitle(
                title: L10n.channels,
                addButtonText: L10n.newChannel,
                onAddButtonPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddChannel(
                        category: category,
                        channel: Channel.empty(),
                      ),
                    ),
                  );
                },
              ),
              AutoSizeText(
                "${category.channels.length} ${L10n.channels}",
              ),
              const SizedBox(height: 20),
              Builder(
                builder: (context) {
                  if (category.channels.isEmpty) {
                    return const EmptyText(
                      L10n.noChannels,
                      height: 200,
                    );
                  }
                  return Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 20,
                    runSpacing: 20,
                    children: List.generate(
                      category.channels.length,
                      (index) => ChannelCard(
                        categoryId: category.id,
                        channel: category.channels[index],
                      ),
                    ),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
