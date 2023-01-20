import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:web_panel/buisness_logic/event_channels_bloc/event_channels_bloc_bloc.dart';
import 'package:web_panel/buisness_logic/event_match_bloc/event_match_bloc.dart';
import 'package:web_panel/core/extension/context.dart';
import 'package:web_panel/data/models/event_match.dart';
import 'package:web_panel/presentation/screens/general/margined_body.dart';
import 'package:web_panel/presentation/screens/general/screen_title.dart';

import '../../../data/providers/l10n/en.dart';
import '../../config/colors/colors.dart';
import '../add_event_match_page/add_event_match_page.dart';
import '../general/action_button.dart';
import '../general/event_match_card.dart';
import '../update_event_match/update_event_match.dart';

class MathEvents extends StatelessWidget {
  const MathEvents({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: MarginedBody(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ScreenTitle(
                  title: title,
                  onAddButtonPressed: () {
                    context.push(
                      AddEventMatchPage(
                        eventMatch: EventMatch.empty(),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<EventChannelsBlocBloc, EventChannelsBlocState>(
                  builder:
                      (BuildContext context, EventChannelsBlocState state) {
                    if (state.isLoading) {
                      return const CircularProgressIndicator();
                    } else if (state.eventMatches != null) {
                      return Center(
                        child: Wrap(
                          children: List.generate(
                            state.eventMatches!.length,
                            (index) {
                              EventMatch current = state.eventMatches![index];

                              return EventMatchCard(
                                onTap: () {
                                  context.push(
                                    UpdateEventMatchPage(
                                      eventMatch: current,
                                    ),
                                  );
                                },
                                eventMatch: current,
                              );
                            },
                          ),
                        ),
                      );
                    } else {
                      return const Text(L10n.menuItemAddedError);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
