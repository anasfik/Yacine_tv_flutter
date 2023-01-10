import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_panel/buisness_logic/bloc_providers/bloc_providers.dart';

import '../../../buisness_logic/channel_bloc/channel_bloc.dart';
import '../../../buisness_logic/channels_categories_bloc/channels_categories_bloc.dart';
import '../../../data/models/channel.dart';
import '../../../data/repositories/channels_categories_repository/channels_categories_repository.dart';
import '../edit_channel/edit_channel.dart';

class ChannelCard extends StatelessWidget {
  const ChannelCard({
    super.key,
    required this.channel,
    required this.categoryId,
  });

  final String categoryId;
  final Channel channel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChannelBloc>(
      create: (context) => ChannelBloc(
        channel,
        ChannelsCategoriesRepository(),
      ),
      lazy: false,
      child: BlocBuilder<ChannelBloc, ChannelState>(
        builder: (context, state) {
          return Card(
            child: Column(
              children: [
                Image.network(
                  "https://via.placeholder.com/100x100",
                  width: 100,
                  height: 100,
                ),
                Text(channel.channelName),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                              value: context.read<ChannelBloc>(),
                              child: EditChannel(
                                channel: channel,
                                categoryId: categoryId,
                              ),
                            ),
                          ),
                        );
                      },
                      child: const Text('Edit'),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<ChannelBloc>().add(
                              DeleteChannel(
                                onSuccess: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Channel deleted'),
                                    ),
                                  );
                                  context
                                      .read<ChannelsCategoriesBloc>()
                                      .add(NewCategoriesGetRequested());
                                  Navigator.pop(context);
                                },
                                onError: (erro) {},
                                categoryId: categoryId,
                                channelId: channel.id,
                              ),
                            );
                      },
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
