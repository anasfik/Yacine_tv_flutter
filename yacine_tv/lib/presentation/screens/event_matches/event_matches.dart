import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yacine_tv/data/models/event_matches.dart';
import 'package:yacine_tv/presentation/screens/general/margined_body.dart';

import '../../../logic/event_matches/event_matches_cubit.dart';
import 'widgets/event_match_card.dart';

class EventMatches extends StatelessWidget {
  const EventMatches({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocBuilder<EventMatchesCubit, EventMatchesState>(
        builder: (context, state) {
          if (state is EventMatchesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EventMatchesLoaded) {
            final eventMatches = state.eventMatches!;
            // if (eventMatches.isEmpty) {}

            return RefreshIndicator(
              onRefresh: () {
                return context.read<EventMatchesCubit>().loadEventMatches();
              },
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  ListView.builder(
                    itemCount: eventMatches.length,
                    itemBuilder: (context, index) {
                      final current = eventMatches[index];

                      return EventMatchCard(eventMatch: current);
                    },
                  ),
                ],
              ),
            );
          } else {
            return const Text("sssss");
          }
        },
      ),
    );
  }
}
