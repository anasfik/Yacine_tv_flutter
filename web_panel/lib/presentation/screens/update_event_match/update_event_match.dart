import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_panel/buisness_logic/event_channels_bloc/event_channels_bloc_bloc.dart';
import 'package:web_panel/data/repositories/match_events/match_events.dart';
import 'package:web_panel/presentation/screens/general/action_button.dart';
import 'package:web_panel/presentation/screens/general/margined_body.dart';
import '../../../buisness_logic/event_match_bloc/event_match_bloc.dart';
import '../../../data/models/event_match.dart';
import '../../../data/providers/l10n/en.dart';
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
        body: BlocBuilder<EventMatchBloc, EventMatchState>(
          builder: (context, state) {
            final bloc = context.read<EventMatchBloc>();

            return SingleChildScrollView(
              child: MarginedBodyForInputs(
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
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Channels",
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(
                          width: 10,
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
                                      content: Text(
                                          "You didn't finish selecting date"),
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
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Channels",
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ChannelsActionButton(
                          text: "channels",
                          onPressed: () async {
                            await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Channels"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("close"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      bloc.add(ChannelsChanged());
                                      print(
                                          state.channels.map((e) => e.quality));
                                      Navigator.pop(context);
                                    },
                                    child: const Text("ok"),
                                  ),
                                ],
                                content: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      DataField(
                                        hint: "Multi",
                                        controller: bloc.channelMultiController,
                                      ),
                                      DataField(
                                        hint: "Low",
                                        controller: bloc.channelLowController,
                                      ),
                                      DataField(
                                        hint: "SD",
                                        controller: bloc.channelSdController,
                                      ),
                                      DataField(
                                        hint: "HD",
                                        controller: bloc.channelHdController,
                                      ),
                                      DataField(
                                        hint: "FHD",
                                        controller: bloc.channelFhdController,
                                      ),
                                      DataField(
                                        hint: "UHD",
                                        controller: bloc.channelUhdController,
                                      ),
                                      DataField(
                                        hint: "4k",
                                        controller: bloc.channel4kController,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
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
                                      content:
                                          Text("Error updating event match"),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        DeleteActionButton(
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
                                      content:
                                          Text("Error deleting event match"),
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
                      height: 10,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
