class EventMatch {
  EventMatch({
    required this.id,
    required this.firstTeam,
    required this.firstTeamLogo,
    required this.secondTeam,
    required this.secondTeamLogo,
    required this.cupName,
    required this.channelName,
    required this.channelsQuality,
    required this.commenterName,
    required this.dateOfMatchWithTime,
  });

  final String id;
  final String firstTeam;
  final String firstTeamLogo;
  final String secondTeam;
  final String secondTeamLogo;
  final String cupName;
  final String channelName;
  final List<ChannelsQuality> channelsQuality;
  final String commenterName;
  final DateTime dateOfMatchWithTime;

  factory EventMatch.fromMap(Map<String, dynamic> json) => EventMatch(
        id: json["_id"],
        firstTeam: json["first_team"],
        firstTeamLogo: json["first_team_logo"],
        secondTeam: json["second_team"],
        secondTeamLogo: json["second_team_logo"],
        cupName: json["cup_name"],
        channelName: json["channel_name"],
        channelsQuality: List<ChannelsQuality>.from(
          json["channels_quality"]!.map(
            (x) => ChannelsQuality.fromMap(x),
          ),
        ),
        commenterName: json["commenter_name"],
        dateOfMatchWithTime: DateTime.parse(json["date_of_match_with_time"]),
      );

  Map<String, dynamic> toMap() => {
        "first_team": firstTeam,
        "first_team_logo": firstTeamLogo,
        "second_team": secondTeam,
        "second_team_logo": secondTeamLogo,
        "cup_name": cupName,
        "channel_name": channelName,
        "channels_quality":
            List<dynamic>.from(channelsQuality.map((x) => x.toMap())),
        "commenter_name": commenterName,
        "date_of_match_with_time": dateOfMatchWithTime.toIso8601String(),
      };

  factory EventMatch.empty() {
    return EventMatch(
      id: "_",
      firstTeam: "",
      firstTeamLogo: "https://via.placeholder.com/100x100",
      secondTeam: "",
      secondTeamLogo: "https://via.placeholder.com/100x100",
      cupName: "",
      channelName: "",
      channelsQuality: [],
      commenterName: "",
      dateOfMatchWithTime: DateTime.now(),
    );
  }
}

class ChannelsQuality {
  ChannelsQuality({
    required this.quality,
    required this.channelUrl,
  });

  String? quality;
  String? channelUrl;

  factory ChannelsQuality.fromMap(Map<String, dynamic> json) => ChannelsQuality(
        quality: json["quality"],
        channelUrl: json["channel_url"],
      );

  Map<String, dynamic> toMap() => {
        "quality": quality,
        "channel_url": channelUrl,
      };
}
