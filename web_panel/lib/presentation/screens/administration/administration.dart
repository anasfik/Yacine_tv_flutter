import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../config/colors/colors.dart';
import '../general/action_button.dart';
import 'widgets/app_bar.dart';

class Administration extends StatelessWidget {
  const Administration({
    super.key,
    required this.title,
  });

  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AAppBar(),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
              ),
              Row(
                children: <Widget>[
                  ActionButton(
                    icon: const Icon(
                      FlutterRemix.add_line,
                      size: 18,
                    ),
                    height: 30,
                    onPressed: () {},
                    text: "Add",
                  ),
                  const SizedBox(width: 10),
                  Column(
                    children: [],
                  )
                ],
              )
            ],
          ),
        ],
      )),
    );
  }
}
