import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:web_panel/data/providers/interfaces/data_type_interface.dart';
import 'package:http/http.dart' as http;

import '../../models/menu_item.dart';

class MenuProvider implements DataTypeInterface {
  static String endPoint = "/drawer_menu";

  static Future<String> get() async {
    http.Response response = await http.get(
      Uri.https(
        dotenv.env['API_URL']!,
        endPoint,
      ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    return response.body;
  }

  static post(MenuItem item) async {
    http.Response response = await http.post(
      Uri.https(
        dotenv.env['API_URL']!,
        endPoint,
      ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(item.toMap()),
    );

    return response.body;
  }

  static put(MenuItem item, String id) async {
    http.Response response = await http.put(
      Uri.https(
        dotenv.env['API_URL']!,
        "$endPoint/$id",
      ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(item.toMap()),
    );

    return response.body;
  }

  static Future<String> delete(String id) async {
    final res = await http.delete(
      Uri.https(
        dotenv.env['API_URL']!,
        "$endPoint/$id",
      ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    return res.body;
  }
}
