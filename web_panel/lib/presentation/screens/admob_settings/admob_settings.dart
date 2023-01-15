import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:web_panel/buisness_logic/settings_bloc/settings_bloc.dart';
import 'package:web_panel/data/providers/l10n/en.dart';
import 'package:web_panel/presentation/screens/general/data_field.dart';
import 'package:web_panel/presentation/screens/general/margined_body.dart';

import '../../config/colors/colors.dart';
import '../general/action_button.dart';

class AdmobSettings extends StatelessWidget {
  const AdmobSettings({
    super.key,
    required this.title,
  });

  final String title;
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SettingsBloc>();
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const CircularProgressIndicator();
            } else if (state.settings != null) {
              return MarginedBodyForInputs(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          title,
                          style:
                              Theme.of(context).textTheme.headline4?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black,
                                  ),
                        ),
                      ],
                    ),
                    SwitchListTile(
                      value: state.showAds,
                      title: const Text("enable admob"),
                      onChanged: (value) {
                        bloc.add(ShowAdsSwitched(value: value));
                      },
                    ),
                    if (state.showAds) ...[
                      DataField(
                        hint: "Admob App ID",
                        controller: bloc.admobAppIdController,
                      ),
                      DataField(
                        hint: "Admob banner id",
                        controller: bloc.admobBannerIdController,
                      ),
                      DataField(
                        hint: "Admob interstitial id",
                        controller: bloc.admobInterstitialIdController,
                      ),
                    ],
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
                              SettingsUpdated(
                                onError: (e) {
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
                    )
                  ],
                ),
              );
            } else {
              return Text("no data");
            }
          },
        ),
      ),
    );
  }
}
