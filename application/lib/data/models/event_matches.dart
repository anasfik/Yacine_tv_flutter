class EventMatch {
  final String id;
  final String firstTeam;
  final String firstTeamLogo;
  final String secondTeam;
  final String secondTeamLogo;
  final String cupName;
  final String channelName;
  final List<ChannelQuality> channelQuality;
  final String commenterName;
  final DateTime dateOfMatchWithTime;

  EventMatch({
    required this.id,
    required this.firstTeam,
    required this.firstTeamLogo,
    required this.secondTeam,
    required this.secondTeamLogo,
    required this.cupName,
    required this.channelName,
    required this.channelQuality,
    required this.commenterName,
    required this.dateOfMatchWithTime,
  });

  factory EventMatch.fromMap(Map<String, dynamic> json) => EventMatch(
        id: json["_id"],
        firstTeam: json["first_team"],
        firstTeamLogo: json["first_team_logo"],
        secondTeam: json["second_team"],
        secondTeamLogo: json["second_team_logo"],
        cupName: json["cup_name"],
        channelName: json["channel_name"],
        channelQuality: List<ChannelQuality>.from(
          json["channels_quality"]!.map(
            (x) => ChannelQuality.fromMap(x),
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
            List<dynamic>.from(channelQuality.map((x) => x.toMap())),
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
      channelQuality: [
        ChannelQuality(quality: "MULTI", channelUrl: ""),
        ChannelQuality(quality: "LOW", channelUrl: ""),
        ChannelQuality(quality: "SD", channelUrl: ""),
        ChannelQuality(quality: "HD", channelUrl: ""),
        ChannelQuality(quality: "FHD", channelUrl: ""),
        ChannelQuality(quality: "UHD", channelUrl: ""),
        ChannelQuality(quality: "4K", channelUrl: ""),
      ],
      commenterName: "",
      dateOfMatchWithTime: DateTime.now(),
    );
  }
}

class ChannelQuality {
  String? quality;
  String? channelUrl;

  ChannelQuality({
    required this.quality,
    required this.channelUrl,
  });

  factory ChannelQuality.fromMap(Map<String, dynamic> json) => ChannelQuality(
        quality: json["quality"],
        channelUrl: json["channel_url"],
      );

  Map<String, dynamic> toMap() => {
        "quality": quality,
        "channel_url": channelUrl,
      };
  bool isValid() {
    return channelUrl != null && channelUrl!.isNotEmpty;
  }

}
