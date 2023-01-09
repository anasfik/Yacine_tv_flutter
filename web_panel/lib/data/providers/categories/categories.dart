import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../interfaces/data_type_interface.dart';
import 'package:http/http.dart' as http;

class CategoriesProvider implements DataTypeInterface {
  @override
  String get endPoint => "/categories";

  static Future<String> get() async {
    http.Response res = await http.get(
      Uri.http(
        dotenv.env['API_URL']!,
        '/categories',
      ),
      // headers: {
      //   'Content-Type': 'application/json',
      //   'Accept': 'application/json',
      // },
    );

    return res.body;
  }
}
