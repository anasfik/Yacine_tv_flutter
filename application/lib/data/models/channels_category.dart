import 'channel.dart';

class ChannelsCategory {
  ChannelsCategory({
    required this.id,
    required this.categoryTitle,
    required this.channels,
  });

  final String id;
  final String categoryTitle;
  final List<Channel> channels;

  factory ChannelsCategory.fromMap(Map<String, dynamic> json) =>
      ChannelsCategory(
        id: json["_id"],
        categoryTitle: json["category_title"],
        channels: List<Channel>.from(
          json["channels"].map(
            (x) => Channel.fromMap(x),
          ),
        ),
      );

  Map<String, dynamic> toMapWithOnlyTitle() => {
        "category_title": categoryTitle,
      };

  Map<String, dynamic> toMap() => {
        "category_title": categoryTitle,
        "channels": List<dynamic>.from(
          channels.map(
            (x) => x.toMap(),
          ),
        ),
      };
}
