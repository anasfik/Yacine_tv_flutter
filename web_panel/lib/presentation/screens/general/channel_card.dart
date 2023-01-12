import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_panel/buisness_logic/bloc_providers/bloc_providers.dart';
import 'package:web_panel/data/providers/l10n/en.dart';

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
          return SizedBox(
            width: 150,
            child: Material(
              elevation: 2.5,
              borderRadius: BorderRadius.circular(10),
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                onTap: () {
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.network(
                      channel.channelImage,
                      height: 150,
                      width: 150,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    AutoSizeText(
                      channel.channelName,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(
                      height: 12.5,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            onPressed: () {
                              context.read<ChannelBloc>().add(
                                    DeleteChannel(
                                      onSuccess: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(L10n.deleted(
                                                channel.channelName)),
                                          ),
                                        );
                                        context
                                            .read<ChannelsCategoriesBloc>()
                                            .add(NewCategoriesGetRequested());
                                        Navigator.pop(context);
                                      },
                                      onError: (erro) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                L10n.channelsCategoriesError),
                                          ),
                                        );
                                      },
                                      categoryId: categoryId,
                                      channelId: channel.id,
                                    ),
                                  );
                            },
                            child: Expanded(
                              child: AutoSizeText(
                                'Delete',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      color: Theme.of(context).primaryColor,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
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
                  children: [],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
