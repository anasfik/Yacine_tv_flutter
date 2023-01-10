import 'dart:convert';

import '../../providers/auth/auth_provider.dart';

class AuthRepository {
  Future<bool> login({
    required String username,
    required String password,
  }) async {
    final loginResponse = await AuthProvider.login(username, password);
    if (loginResponse.statusCode == 200) {
      return true;
    } else {
      final body = jsonDecode(loginResponse.body);
      throw Exception(body['message'] ?? 'Unknown error');
    }
  }
}
