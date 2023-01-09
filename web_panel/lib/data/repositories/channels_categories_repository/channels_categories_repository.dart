import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../models/chennels_category.dart';
import '../../providers/categories/categories.dart';

class ChannelsCategoriesRepository {
  Future<List<ChannelsCategory>> getChannelsCategories() async {
    final resBody = await CategoriesProvider.get();
    final res = jsonDecode(resBody) as Map<String, dynamic>;
    final data = (res["data"] as List).cast<Map<String, dynamic>>();
    final result =
        data.map((x) => ChannelsCategory.fromMap(Map.from(x))).toList();

    return result;
  }

  Future<void> createChannelsCategory(
    ChannelsCategory channelsCategory,
  ) async {
    final resBody = await CategoriesProvider.post(channelsCategory.toMap());
    print(resBody);
  }

  Future updateChannel(
    String categoryId,
    Channel channel,
  ) async {
    final resBody = await CategoriesProvider.putChannel(
      categoryId,
      channel,
    );
    print(resBody);
  }

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

  Future<void> deleteCategory(
    String categoryId,
  ) async {
    final resBody = await CategoriesProvider.deleteCategory(categoryId);
    print(resBody);
  }

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
