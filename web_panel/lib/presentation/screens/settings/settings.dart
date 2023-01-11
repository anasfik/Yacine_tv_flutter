import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:web_panel/buisness_logic/settings_bloc/settings_bloc.dart';
import 'package:web_panel/presentation/screens/general/data_field.dart';

import '../../config/colors/colors.dart';
import '../general/action_button.dart';

class Settings extends StatelessWidget {
  const Settings({
    super.key,
    required this.title,
  });

  final String title;
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SettingsBloc>();
    return Scaffold(
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
              ],
            ),
            DataField(
              hint: "privacy & policy link",
              controller: bloc.privacyController,
            )
          ],
        ),
      ),
    );
  }
}
