import 'package:flutter/material.dart';
import 'package:yacine_tv/core/extensions/context.dart';
import 'package:yacine_tv/presentation/config/colors.dart';
import 'package:yacine_tv/presentation/screens/general/margined_body.dart';

import '../../../../data/models/event_matches.dart';
import 'cup.dart';
import 'event_match_screen.dart';
import 'match_time_info.dart';
import 'team_info.dart';

class EventMatchCard extends StatelessWidget {
  const EventMatchCard({
    super.key,
    required this.eventMatch,
  });

  final EventMatch eventMatch;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: InkWell(
        splashColor: MainColors.lightGrey,
        onTap: () {
          context.navigatorPush(EventMatchScreen(eventMatch: eventMatch));
        },
        child: MarginedBody(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TeamInfo(
                    name: eventMatch.firstTeam,
                    logoUrl: eventMatch.firstTeamLogo,
                  ),
                  Spacer(),
                  MatchTimeInfo(date: eventMatch.dateOfMatchWithTime),
                  Spacer(),
                  TeamInfo(
                    name: eventMatch.secondTeam,
                    logoUrl: eventMatch.secondTeamLogo,
                  ),
                ],
              ),
              const SizedBox(height: 18),
              AdditionalInfo(
                text: eventMatch.cupName,
                icon: Icons.emoji_events,
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  AdditionalInfo(
                    text: eventMatch.commenterName,
                    icon: Icons.mic,
                  ),
                  AdditionalInfo(
                    text: eventMatch.channelName,
                    icon: Icons.live_tv_rounded,
                  ),
                ],
              ),
              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }
}
