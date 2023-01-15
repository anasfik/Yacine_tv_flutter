import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../interfaces/data_type.dart';

import 'package:http/http.dart' as http;

class SettingsProvider extends DataTypeInterface {
  static String endPoint = "/app_settings";

  static Future<String> get() async {
    http.Response response = await http.get(
      Uri.http(
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
}
