import 'package:flutter/material.dart';
import 'package:web_panel/core/extension/context.dart';
import 'package:web_panel/presentation/config/colors/colors.dart';
import 'package:web_panel/presentation/screens/general/team_info.dart';

import '../../../data/models/event_match.dart';
import 'additional_info.dart';
import 'margined_body.dart';
import 'match_time_info.dart';

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
        splashColor: AppColors.lightGrey,
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
                  MatchTimeInfo(date: eventMatch.dateOfMatchWithTime),
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
