import 'package:flutter/material.dart';
import 'package:web_panel/presentation/screens/general/margined_body.dart';

import '../general/data_field.dart';

class AddChannelCategory extends StatelessWidget {
  const AddChannelCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Category"),
      ),
      body: MarginedBody(
        child: Column(
          children: <Widget>[
            DataField(
              hint: "Category Name",
              controller: TextEditingController(),
            ),
          ],
        ),
      ),
    );
  }
}
