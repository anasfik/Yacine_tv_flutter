import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_panel/data/models/chennels_category.dart';
import 'package:web_panel/data/providers/l10n/en.dart';
import 'package:web_panel/data/repositories/channels_categories_repository/channels_categories_repository.dart';
import 'package:web_panel/presentation/screens/general/action_button.dart';
import 'package:web_panel/presentation/screens/general/app_bar.dart';
import 'package:web_panel/presentation/screens/general/data_field.dart';
import 'package:web_panel/presentation/screens/general/margined_body.dart';

import '../../../buisness_logic/channel_bloc/channel_bloc.dart';
import '../../../buisness_logic/channels_categories_bloc/channels_categories_bloc.dart';
import '../../../data/models/channel.dart';
import 'widgets/app_bar.dart';

class AddChannel extends StatelessWidget {
  const AddChannel({
    super.key,
    required this.category,
    required this.channel,
  });
  final ChannelsCategory category;
  final Channel channel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChannelBloc(
        channel,
        ChannelsCategoriesRepository(),
      ),
      child: Builder(builder: (context) {
        final bloc = context.read<ChannelBloc>();
        return Scaffold(
          appBar: const DSAppBar(
            title: L10n.addChannel,
          ),
          body: MarginedBodyForInputs(
            child: Column(
              children: [
                DataField(
                  hint: 'Channel Logo Link',
                  controller: bloc.channelImageUrlController,
                ),
                DataField(
                  hint: 'Channel Name',
                  controller: bloc.channelNameController,
                ),
                DataField(
                  hint: 'Channel Stream Link',
                  controller: bloc.channelStreamUrlController,
                ),
                DataField(
                  hint: 'Channel tags',
                  controller: bloc.channelTagsController,
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    AddActionButton(
                      text: L10n.add,
                      onPressed: () {
                        bloc.add(
                          AddedChannel(
                            onSuccess: () {
                              final String categoryName =
                                  category.categoryTitle;
                              final String channelName =
                                  bloc.channelNameController.text;
                              context
                                  .read<ChannelsCategoriesBloc>()
                                  .add(NewCategoriesGetRequested());
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      '$channelName Is Added to  $categoryName Successfully'),
                                ),
                              );

                              Navigator.of(context)
                                  .popUntil((route) => route.isFirst);
                            },
                            onError: (er) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(L10n.channelsCategoriesError),
                                ),
                              );
                            },
                            categoryId: category.id,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
