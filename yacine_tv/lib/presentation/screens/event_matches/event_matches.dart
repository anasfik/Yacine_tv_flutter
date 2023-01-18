import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yacine_tv/core/lang/en.dart';
import 'package:yacine_tv/data/models/event_matches.dart';
import 'package:yacine_tv/presentation/config/colors.dart';
import 'package:yacine_tv/presentation/screens/general/emptiness.dart';
import 'package:yacine_tv/presentation/screens/general/loading.dart';

import '../../../logic/event_matches/event_matches_cubit.dart';
import 'widgets/event_match_card.dart';

class EventMatches extends StatelessWidget {
  const EventMatches({super.key});

  @override
  Widget build(BuildContext context) {
    EventMatchesCubit cubit = context.read<EventMatchesCubit>();

    return Scaffold(
      backgroundColor: MainColors.transparent,
      body: BlocBuilder<EventMatchesCubit, EventMatchesState>(
        builder: (context, state) {
          if (state is EventMatchesLoading) {
            return const LoadingWidget();
          } else if (state is EventMatchesLoaded) {
            List<EventMatch> eventMatches = state.eventMatches ?? [];

            if (eventMatches.isEmpty) {
              return const EmptinessWidget();
            }

            return RefreshIndicator(
              onRefresh: () {
                return cubit.loadEventMatches();
              },
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  ListView.builder(
                    itemCount: eventMatches.length,
                    itemBuilder: (context, index) {
                      EventMatch current = eventMatches[index];

                      return EventMatchCard(eventMatch: current);
                    },
                  ),
                ],
              ),
            );
          } else {
            return ErrorWidget(L10n.error);
          }
        },
      ),
    );
  }
}
