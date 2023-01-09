import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_panel/data/repositories/channels_categories_repository/channels_categories_repository.dart';
import 'package:web_panel/presentation/screens/general/action_button.dart';
import 'package:web_panel/presentation/screens/general/data_field.dart';

import '../../../buisness_logic/channel_bloc/channel_bloc.dart';
import '../../../buisness_logic/channels_categories_bloc/channels_categories_bloc.dart';
import '../../../data/models/chennels_category.dart';

class AddChannel extends StatelessWidget {
  const AddChannel({
    super.key,
    required this.categoryId,
    required this.channel,
  });
  final String categoryId;
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
          appBar: AppBar(
            title: const Text('Add Channel'),
          ),
          body: Column(
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
              ActionButton(
                text: 'add',
                onPressed: () {
                  bloc.add(
                    AddedChannel(
                      onSuccess: () {
                        context
                            .read<ChannelsCategoriesBloc>()
                            .add(NewCategoriesGetRequested());
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Channel added'),
                          ),
                        );

                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      },
                      onError: (er) {},
                      categoryId: categoryId,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
