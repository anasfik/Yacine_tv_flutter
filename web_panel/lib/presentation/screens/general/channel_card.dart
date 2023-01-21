import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_panel/core/extension/context.dart';
import 'package:web_panel/data/providers/l10n/en.dart';

import '../../../buisness_logic/channel_bloc/channel_bloc.dart';
import '../../../buisness_logic/channels_categories_bloc/channels_categories_bloc.dart';
import '../../../data/models/channel.dart';
import '../../../data/repositories/channels_categories_repository/channels_categories_repository.dart';
import '../edit_channel/edit_channel.dart';

class ChannelCard extends StatelessWidget {
  final String categoryId;
  final Channel channel;

  const ChannelCard({
    super.key,
    required this.channel,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return BlocProvider<ChannelBloc>(
      create: (context) => ChannelBloc(
        channel,
        ChannelsCategoriesRepository(),
      ),
      lazy: false,
      child: BlocBuilder<ChannelBloc, ChannelState>(
        builder: (BuildContext context, ChannelState state) {
          return SizedBox(
            width: 150,
            child: Material(
              elevation: 2.5,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                onTap: () {
                  context.push(
                    BlocProvider.value(
                      value: context.read<ChannelBloc>(),
                      child: EditChannel(
                        channel: channel,
                        categoryId: categoryId,
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
                      style: theme.textTheme.labelLarge,
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
                                        context.snackBarText(
                                          L10n.deleted(channel.channelName),
                                        );
                                        context
                                            .read<ChannelsCategoriesBloc>()
                                            .add(NewCategoriesGetRequested());
                                        context.pop();
                                      },
                                      onError: (error) {
                                        context.snackBarText(
                                          L10n.channelsCategoriesError,
                                        );
                                      },
                                      categoryId: categoryId,
                                      channelId: channel.id,
                                    ),
                                  );
                            },
                            child: AutoSizeText(
                              L10n.delete,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: theme.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
