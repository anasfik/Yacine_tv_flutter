import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:web_panel/buisness_logic/settings_bloc/settings_bloc.dart';
import 'package:web_panel/presentation/screens/general/data_field.dart';
import 'package:web_panel/presentation/screens/general/margined_body.dart';
import 'package:web_panel/presentation/screens/general/screen_title.dart';

import '../../../data/providers/l10n/en.dart';
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
      body: MarginedBodyForInputs(
        child: SingleChildScrollView(
          child: BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              if (state.isLoading) {
                return Column(
                  children: [
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                );
              } else if (state.settings != null) {
                return Column(
                  children: <Widget>[
                    ScreenTitle(
                      showAddButton: false,
                      title: title,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DataField(
                      hint: "App Version",
                      controller: bloc.versionController,
                    ),
                    DataField(
                      hint: "Author name",
                      controller: bloc.authorController,
                    ),
                    DataField(
                      hint: "App Cover Logo",
                      controller: bloc.logoCoverController,
                    ),
                    DataField(
                      hint: "Email",
                      controller: bloc.emailController,
                    ),
                    DataField(
                      hint: "Website",
                      controller: bloc.websiteController,
                    ),
                    DataField(
                      hint: "privacy & policy link",
                      controller: bloc.privacyController,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Share App",
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    SwitchListTile(
                      activeColor: Theme.of(context).primaryColor,
                      value: state.showShare,
                      title: const Text("Allow sharing"),
                      onChanged: (value) {
                        bloc.add(ShowShareSwitched(value: value));
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        UpdateActionButton(
                          text: L10n.update,
                          onPressed: () {
                            bloc.add(
                              SettingsUpdated(
                                onError: (error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(L10n.updateError),
                                    ),
                                  );
                                },
                                onSuccess: () {
                                  bloc.add(SettingsRequested());
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(L10n.updateSuccess),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                );
              } else {
                return const Text("no data");
              }
            },
          ),
        ),
      ),
    );
  }
}
