import 'dart:convert';

import 'package:http/http.dart';

import '../../providers/auth/auth_provider.dart';

class AuthRepository {
  Future<bool> login({
    required String username,
    required String password,
  }) async {
    Response loginResponse = await AuthProvider.login(username, password);
    if (loginResponse.statusCode == 200) {
      return true;
    } else {
      final body = jsonDecode(loginResponse.body);
      throw Exception(body['message'] ?? 'Unknown error');
    }
  }
}
