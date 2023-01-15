import 'dart:convert';

import '../../models/menu_item.dart';
import '../../providers/menu/menu.dart';

class MenuRepository {
  Future<List<MenuItem>> getMenuItems() async {
    final resBody = await MenuProvider.get();
    final res = jsonDecode(resBody) as Map<String, dynamic>;
    final data = (res["data"] as List).cast<Map<String, dynamic>>();
    final result = data.map((x) => MenuItem.fromMap(Map.from(x))).toList();

    return result;
  }
}
