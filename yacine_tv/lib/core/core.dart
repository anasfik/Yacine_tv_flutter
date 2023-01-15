import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:yacine_tv/data/models/channel.dart';
import '../config/general.dart';
import '../data/models/channels_category.dart';

class Core {
  // Initializitaion method.
  static Future<void> init() async {
    // Load the environment variables.
    await dotenv.load(fileName: Configs.environmentFilePath);
  }

  static Iterable<Channel> customChannelsSearch(
    Iterable<Channel> channels, {
    String searchQuery = "",
  }) {
    if (searchQuery.isEmpty) {
      return [];
    }

    Iterable<Channel> results = channels.where((channel) {
      return channel.titleContains(searchQuery) ||
          channel.tagsContains(searchQuery);
    }).toList();

    return results;
  }

  static Iterable<Channel> customCategoriesChannelsSearch(
    Iterable<ChannelsCategory> categories, {
    String searchQuery = "",
  }) {
    if (searchQuery.isEmpty) {
      return [];
    }
    final allCategoriesChannels = categories
        .map((category) => category.channels)
        .expand((channels) => channels);

    return customChannelsSearch(
      allCategoriesChannels,
      searchQuery: searchQuery,
    );
  }
}
