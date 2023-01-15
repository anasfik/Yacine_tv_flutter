import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_panel/presentation/screens/general/action_button.dart';
import 'package:web_panel/presentation/screens/general/app_bar.dart';
import 'package:web_panel/presentation/screens/general/data_field.dart';
import 'package:web_panel/presentation/screens/general/margined_body.dart';
import '../../../buisness_logic/channel_bloc/channel_bloc.dart';
import '../../../buisness_logic/channels_categories_bloc/channels_categories_bloc.dart';
import '../../../data/models/channel.dart';
import '../../../data/providers/l10n/en.dart';

class EditChannel extends StatelessWidget {
  const EditChannel({
    super.key,
    required this.categoryId,
    required this.channel,
  });
  final String categoryId;
  final Channel channel;
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ChannelBloc>();
    return Scaffold(
      appBar: DSAppBar(
        title: L10n.updateChannel(channel.channelName),
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
                UpdateActionButton(
                  text: L10n.update,
                  onPressed: () {
                    bloc.add(
                      UpdateChannel(
                        onSuccess: () {
                          context
                              .read<ChannelsCategoriesBloc>()
                              .add(NewCategoriesGetRequested());
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  L10n.channelUpdated(channel.channelName)),
                            ),
                          );

                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                        },
                        onError: (er) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(L10n.updateError),
                            ),
                          );
                        },
                        categoryId: categoryId,
                        channelId: channel.id,
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
  }
}
