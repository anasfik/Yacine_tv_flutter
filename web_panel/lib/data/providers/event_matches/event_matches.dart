import 'dart:convert';
import 'dart:html';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:web_panel/data/providers/interfaces/data_type_interface.dart';

import '../../models/event_match.dart';

import 'package:http/http.dart' as http;

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

  static Future<String> post(EventMatch eventMatch) async {
    http.Response response = await http.post(
      Uri.http(
        dotenv.env['API_URL']!,
        endPoint,
      ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(eventMatch.toMap()),
    );
    return response.body;
  }

  static Future<String> put(EventMatch eventMatch) async {
    http.Response response = await http.put(
      Uri.http(
        dotenv.env['API_URL']!,
        "$endPoint/${eventMatch.id}",
      ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(eventMatch.toMap()),
    );

    return response.body;
  }

  static Future<String> delete(EventMatch eventMatch) async {
    http.Response response = await http.delete(
      Uri.http(
        dotenv.env['API_URL']!,
        "$endPoint/${eventMatch.id}",
      ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    return response.body;
  }
}
