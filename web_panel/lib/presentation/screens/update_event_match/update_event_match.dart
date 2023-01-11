import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_panel/buisness_logic/event_channels_bloc/event_channels_bloc_bloc.dart';
import 'package:web_panel/data/repositories/match_events/match_events.dart';
import 'package:web_panel/presentation/screens/general/action_button.dart';
import 'package:web_panel/presentation/screens/general/margined_body.dart';
import '../../../buisness_logic/event_match_bloc/event_match_bloc.dart';
import '../../../data/models/event_match.dart';
import '../add_event_match_page/date_time_select.dart';
import '../general/data_field.dart';
import 'widgets/app_bar.dart';

class UpdateEventMatchPage extends StatelessWidget {
  const UpdateEventMatchPage({
    super.key,
    required this.eventMatch,
  });
  final EventMatch eventMatch;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EventMatchBloc>(
      create: (context) => EventMatchBloc(
        eventMatch: eventMatch,
        matchEventsRepository: MatchEventsRepository(),
      ),
      child: Scaffold(
        appBar: const AEMAppBar(),
        body: MarginedBody(
          child: BlocBuilder<EventMatchBloc, EventMatchState>(
            builder: (context, state) {
              final bloc = context.read<EventMatchBloc>();

              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    DataField(
                      hint: "first team name",
                      controller: bloc.firstTeamNameController,
                    ),
                    DataField(
                      hint: "first team logo link",
                      controller: bloc.firstTeamImageController,
                    ),
                    DataField(
                        hint: "second team name",
                        controller: bloc.secondTeamNameController),
                    DataField(
                      hint: "second team logo link",
                      controller: bloc.secondTeamImageController,
                    ),
                    DataField(
                      hint: "cup name",
                      controller: bloc.cupNameController,
                    ),
                    DataField(
                      hint: "channel name",
                      controller: bloc.channelNameController,
                    ),
                    DataField(
                      hint: "commenter name",
                      controller: bloc.commenterNameController,
                    ),
                    DateTimeSelect(
                      date: state.matchDateTime,
                      onPressed: () {
                        bloc.add(
                          DateTimeSelected(
                            context,
                            onUserNotFinishingTimesSelects: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text("You didn't finish selecting date"),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                    ActionButton(
                      text: "update",
                      onPressed: () {
                        bloc.add(
                          UpdateEventMatch(
                            eventMatchId: eventMatch.id,
                            onSuccess: () {
                              context
                                  .read<EventChannelsBlocBloc>()
                                  .add(MatchEventsRequested());

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Event match updates"),
                                ),
                              );
                              Navigator.pop(context);
                            },
                            onError: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Error updating event match"),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                    ActionButton(
                      text: "delete",
                      onPressed: () {
                        bloc.add(
                          DeleteEventMatch(
                            eventMatchId: eventMatch.id,
                            onSuccess: () {
                              context
                                  .read<EventChannelsBlocBloc>()
                                  .add(MatchEventsRequested());

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Event match deleted"),
                                ),
                              );
                              Navigator.pop(context);
                            },
                            onError: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Error deleting event match"),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
