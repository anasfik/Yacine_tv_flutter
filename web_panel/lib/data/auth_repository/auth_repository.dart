import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  Future<bool> login({
    required String username,
    required String password,
  }) async {
    http.Response loginResponse = await http.post(
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

    if (loginResponse.statusCode == 200) {
      return true;
    } else {
      final body = jsonDecode(loginResponse.body);
      throw Exception(body['message'] ?? 'Unknown error');
    }
  }
}
