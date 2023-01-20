import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:web_panel/buisness_logic/event_channels_bloc/event_channels_bloc_bloc.dart';
import 'package:web_panel/buisness_logic/event_match_bloc/event_match_bloc.dart';
import 'package:web_panel/core/extension/context.dart';
import 'package:web_panel/data/models/event_match.dart';
import 'package:web_panel/presentation/screens/general/margined_body.dart';

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
                        onPressed: () {
                          context.push(
                            AddEventMatchPage(
                              eventMatch: EventMatch.empty(),
                            ),
                          );
                        },
                        text: "Add",
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ],
              ),
              BlocBuilder<EventChannelsBlocBloc, EventChannelsBlocState>(
                builder: (BuildContext context, EventChannelsBlocState state) {
                  if (state.isLoading) {
                    return const CircularProgressIndicator();
                  } else if (state.eventMatches != null) {
                    return Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.spaceAround,
                      children: List.generate(
                        state.eventMatches!.length,
                        (index) {
                          EventMatch current = state.eventMatches![index];

                          return GestureDetector(
                            onTap: () {
                              context.push(
                                UpdateEventMatchPage(
                                  eventMatch: current,
                                ),
                              );
                            },
                            child: EventMatchCard(
                              eventMatch: current,
                            ),
                          );
                        },
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
    );
  }
}
