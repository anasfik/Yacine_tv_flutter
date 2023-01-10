import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AuthProvider {
  static login(String username, String password) async {
    final a = await http.post(
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
    return a;
  }
}
