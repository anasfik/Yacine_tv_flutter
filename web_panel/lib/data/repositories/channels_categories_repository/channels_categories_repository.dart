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
}
