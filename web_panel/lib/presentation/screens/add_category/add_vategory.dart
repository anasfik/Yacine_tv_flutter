import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_panel/presentation/screens/general/action_button.dart';
import 'package:web_panel/presentation/screens/general/margined_body.dart';

import '../../../buisness_logic/channels_categories_bloc/channels_categories_bloc.dart';
import '../general/data_field.dart';
import 'widgets/add_category_app_bar.dart';

class AddChannelCategory extends StatelessWidget {
  const AddChannelCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ChannelsCategoriesBloc>();

    return Scaffold(
      appBar: const ADAppBar(),
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
            }),
            ActionButton(
              onPressed: () {
                bloc.add(
                  ChannelsCategoryCreated(
                    onSuccess: () {
                      bloc.add(NewCategoriesGetRequested());
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Category Added"),
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
              text: "Add",
            ),
          ],
        ),
      ),
    );
  }
}
