import 'dart:convert';
import '../../models/channel.dart';
import '../../models/chennels_category.dart';
import '../../providers/categories/categories.dart';

class ChannelsCategoriesRepository {
  /// Returns a list of all the categories.
  /// The list is empty if there are no categories.

  Future<List<ChannelsCategory>> getChannelsCategories() async {
    final resBody = await CategoriesProvider.get();
    final res = jsonDecode(resBody) as Map<String, dynamic>;
    final data = (res["data"] as List).cast<Map<String, dynamic>>();
    final result =
        data.map((x) => ChannelsCategory.fromMap(Map.from(x))).toList();

    return result;
  }

  /// Creates a new category.
  Future<void> createChannelsCategory(
    ChannelsCategory channelsCategory,
  ) async {
    final resBody = await CategoriesProvider.post(channelsCategory);
    print(resBody);
  }

  /// Updates the category.
  Future<void> updateChannelsCategory(
    ChannelsCategory channelsCategory,
  ) async {
    final resBody = await CategoriesProvider.put(
      channelsCategory,
    );
    print(resBody);
  }

  ///  Deletes the category.
  deleteChannelsCategory(
    String id,
  ) async {
    final resBody = await CategoriesProvider.delete(id);
    print(resBody);
  }

  /// Updates a single channel.
  Future<void> updateChannel(
    String categoryId,
    Channel channel,
  ) async {
    final resBody = await CategoriesProvider.putChannel(
      categoryId,
      channel,
    );
    print(resBody);
  }

  /// Deletes a single channel.
  Future<void> deleteChannel(
    String categoryId,
    String channelId,
  ) async {
    final resBody = await CategoriesProvider.deleteChannel(
      categoryId,
      channelId,
    );
    print(resBody);
  }

  /// Deletes a category.
  Future<void> deleteCategory(
    String categoryId,
  ) async {
    final resBody = await CategoriesProvider.delete(categoryId);
    print(resBody);
  }

  /// Adds a new channel to the category.
  Future addChannel(
    String categoryId,
    Channel channel,
  ) async {
    final resBody = await CategoriesProvider.postChannel(
      categoryId,
      channel,
    );
    print(resBody);
  }
}
