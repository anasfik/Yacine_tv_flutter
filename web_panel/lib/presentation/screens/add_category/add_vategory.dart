import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:web_panel/data/providers/l10n/en.dart';
import 'package:web_panel/presentation/screens/general/action_button.dart';
import 'package:web_panel/presentation/screens/general/app_bar.dart';
import 'package:web_panel/presentation/screens/general/margined_body.dart';

import '../../../buisness_logic/channels_categories_bloc/channels_categories_bloc.dart';
import '../general/data_field.dart';

class AddChannelCategory extends StatelessWidget {
  const AddChannelCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ChannelsCategoriesBloc>();

    return Scaffold(
      appBar: const DSAppBar(title: L10n.newCategory),
      body: MarginedBodyForInputs(
        child: Column(
          children: <Widget>[
            BlocBuilder<ChannelsCategoriesBloc, ChannelsCategoriesState>(
                builder: (context, state) {
              return DataField(
                hint: L10n.categoryName,
                onChanged: (value) {
                  bloc.add(ChannelsCategoryTitleEdited(value));
                },
              );
            }),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                  child: ActionButton(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 30,
                    ),
                    text: L10n.add,
                    icon: const Icon(
                      FlutterRemix.save_2_fill,
                      size: 18,
                    ),
                    onPressed: () {
                      bloc.add(
                        ChannelsCategoryCreated(
                          onSuccess: () {
                            bloc.add(NewCategoriesGetRequested());
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(L10n.categoryAddSuccess(
                                    bloc.state.channelsCategoryTitle)),
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(L10n.youCanAddChannels(
                                    bloc.state.channelsCategoryTitle)),
                              ),
                            );
                            Navigator.pop(context);
                          },
                          onError: (error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(L10n.channelsCategoriesError),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
