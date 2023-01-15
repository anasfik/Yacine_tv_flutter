import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_panel/data/models/chennels_category.dart';
import 'package:web_panel/presentation/screens/general/action_button.dart';
import 'package:web_panel/presentation/screens/general/app_bar.dart';
import 'package:web_panel/presentation/screens/general/margined_body.dart';

import '../../../buisness_logic/channels_categories_bloc/channels_categories_bloc.dart';
import '../../../data/providers/l10n/en.dart';
import '../general/data_field.dart';

class UpdateChannelsCategory extends StatelessWidget {
  const UpdateChannelsCategory({
    super.key,
    required this.category,
  });

  final ChannelsCategory category;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ChannelsCategoriesBloc>();
    bloc.categoryTitleController.text = category.categoryTitle;
    return Scaffold(
      appBar: const DSAppBar(title: L10n.updateCategory),
      body: MarginedBodyForInputs(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              BlocBuilder<ChannelsCategoriesBloc, ChannelsCategoriesState>(
                builder: (context, state) {
                  return DataField(
                    hint: "Category Name",
                    controller: bloc.categoryTitleController,
                    onChanged: (value) {
                      bloc.add(ChannelsCategoryTitleEdited(value));
                    },
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  UpdateActionButton(
                    onPressed: () {
                      bloc.add(
                        ChannelsCategoryUpdated(
                          categoryId: category.id,
                          onSuccess: () {
                            bloc.add(NewCategoriesGetRequested());
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(L10n.updateSuccess),
                              ),
                            );
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                          },
                          onError: (error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(L10n.categoryError),
                              ),
                            );
                          },
                        ),
                      );
                    },
                    text: L10n.update,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
