import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_panel/presentation/screens/general/action_button.dart';
import 'package:web_panel/presentation/screens/general/margined_body.dart';

import '../../../buisness_logic/channels_categories_bloc/channels_categories_bloc.dart';
import '../general/data_field.dart';

class UpdateChannelsCategory extends StatelessWidget {
  const UpdateChannelsCategory({
    super.key,
    required this.categoryId,
  });

  final String categoryId;
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ChannelsCategoriesBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Updtae Category"),
      ),
      body: MarginedBody(
        child: Column(
          children: <Widget>[
            BlocBuilder<ChannelsCategoriesBloc, ChannelsCategoriesState>(
              builder: (context, state) {
                return DataField(
                  hint: "Category Name",
                  onChanged: (value) {
                    bloc.add(ChannelsCategoryTitleEdited(value));
                  },
                );
              },
            ),
            ActionButton(
              onPressed: () {
                bloc.add(
                  ChannelsCategoryUpdated(
                    categoryId: categoryId,
                    onSuccess: () {
                      bloc.add(NewCategoriesGetRequested());
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Category updated"),
                        ),
                      );
                      Navigator.pop(context);
                    },
                    onError: (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Error"),
                        ),
                      );
                    },
                  ),
                );
              },
              text: "update",
            ),
          ],
        ),
      ),
    );
  }
}
