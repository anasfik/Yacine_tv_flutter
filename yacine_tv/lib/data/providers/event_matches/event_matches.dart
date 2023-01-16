import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;

import '../../interfaces/data_type.dart';

class MatchEventsProvider implements DataTypeInterface {
  static String endPoint = "/match_events";

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
