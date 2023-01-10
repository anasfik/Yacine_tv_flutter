import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_panel/presentation/screens/general/action_button.dart';
import 'package:web_panel/presentation/screens/general/margined_body.dart';
import '../../../buisness_logic/event_match_bloc/event_match_bloc.dart';
import '../../../data/models/event_match.dart';
import '../general/data_field.dart';
import 'app_bar.dart';
import 'date_time_select.dart';

class AddOrUpdateEventMatchPage extends StatelessWidget {
  const AddOrUpdateEventMatchPage({
    super.key,
    required this.eventMatch,
  });
  final EventMatch eventMatch;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EventMatchBloc>(
      create: (context) => EventMatchBloc(eventMatch: eventMatch),
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
                      text: "Save",
                      onPressed: () {
                        print(state.matchDateTime);
                        print(state.matchTimeOfDay);
                        bloc.add(
                          SaveEventMatch(
                            onSuccess: () {
                              Navigator.pop(context);
                            },
                            onError: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Error saving event match"),
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
