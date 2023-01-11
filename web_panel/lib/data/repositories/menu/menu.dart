import 'dart:convert';

import '../../models/menu_item.dart';
import '../../providers/menu/menu_provider.dart';

class MenuRepository {
  Future<List<MenuItem>> getMatchEvents() async {
    final resBody = await MenuProvider.get();
    final res = jsonDecode(resBody) as Map<String, dynamic>;
    final data = (res["data"] as List).cast<Map<String, dynamic>>();
    final result = data.map((x) => MenuItem.fromMap(Map.from(x))).toList();

    return result;
  }

  Future<void> createMenuItem(MenuItem item) async {
    final resBody = await MenuProvider.post(item);
    print(resBody);
  }

  Future<void> updateMenuItem(MenuItem item, String id) async {
    final resBody = await MenuProvider.put(item, id);
    print(resBody);
  }

  Future<void> deleteMenuItem(String id) async {
    final resBody = await MenuProvider.delete(id);
    print(resBody);
  }
}
