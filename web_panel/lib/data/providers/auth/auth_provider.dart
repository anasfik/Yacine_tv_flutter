import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AuthProvider {
  static Future<http.Response> login(String username, String password) async {
    return await http.post(
      Uri.http(dotenv.env['API_URL']!, '/login'),
      body: jsonEncode(
        {
          'username': username,
          'password': password,
        },
      ),
      headers: {
        "content-type": "application/json",
      },
    );
  }
}
