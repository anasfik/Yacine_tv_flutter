import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:web_panel/data/providers/interfaces/data_type_interface.dart';

import 'package:http/http.dart' as http;

import '../../models/app_settings.dart';

class SettingsProvider extends DataTypeInterface {
  static String endPoint = "/app_settings";

  static Future<String> get() async {
    http.Response response = await http.get(
      Uri.parse(
        dotenv.env['API_URL']! + endPoint,
      ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    return response.body;
  }

  static Future put(AppSettings settings) async {
    http.Response response = await http.put(
        Uri.parse(
          dotenv.env['API_URL']! + endPoint,
        ),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(settings.toMap()));

    return response.body;
  }
}
