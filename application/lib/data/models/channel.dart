class Channel {
  final String id;
  final String channelName;
  final String channelImage;
  final String channelStreamUrl;
  final List<String> tags;

  Channel({
    required this.channelName,
    required this.channelImage,
    required this.channelStreamUrl,
    required this.tags,
    required this.id,
  });

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

  bool titleContains(String query) {
    return channelName.toLowerCase().contains(query.toLowerCase());
  }

  bool tagsContains(String query) {
    return tags.any((tag) => tag.toLowerCase().contains(query.toLowerCase()));
  }

  
}
