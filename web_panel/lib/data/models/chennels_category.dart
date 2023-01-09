// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  Map<String, dynamic> toMap() => {
        "category_title": categoryTitle,
        "channels": List<dynamic>.from(
          channels.map(
            (x) => x!.toMap(),
          ),
        ),
      };
}

class Channel {
  Channel({
    required this.channelName,
    required this.channelImage,
    required this.channelStreamUrl,
    required this.tags,
    required this.id,
  });

  final String id;
  final String channelName;
  final String channelImage;
  final String channelStreamUrl;
  final List<String> tags;

  factory Channel.empty() {
    return Channel(
      id: "_",
      channelName: '',
      channelImage: '',
      channelStreamUrl: '',
      tags: [],
    );
  }
  factory Channel.fromMap(Map<String, dynamic> json) => Channel(
        id: json["_id"],
        channelName: json["channel_name"],
        channelImage: json["channel_image"],
        channelStreamUrl: json["channel_stream_url"],
        tags: (json["tags"] as List).map((x) => x.toString()).toList(),
      );

  Map<String, dynamic> toMap() => {
        "channel_name": channelName,
        "channel_image": channelImage,
        "channel_stream_url": channelStreamUrl,
        "tags": tags,
      };

  Channel copyWith({
    String? id,
    String? channelName,
    String? channelImage,
    String? channelStreamUrl,
    List<String>? tags,
  }) {
    return Channel(
      id: id ?? this.id,
      channelName: channelName ?? this.channelName,
      channelImage: channelImage ?? this.channelImage,
      channelStreamUrl: channelStreamUrl ?? this.channelStreamUrl,
      tags: tags ?? this.tags,
    );
  }
}
