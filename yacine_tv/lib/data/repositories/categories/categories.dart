import 'dart:convert';
import '../../models/channels_category.dart';
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
}
