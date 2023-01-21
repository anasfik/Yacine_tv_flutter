import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;

import '../../interfaces/data_type.dart';

/// This class provides categories data.
///
/// It implements the [DataTypeInterface] interface, which defines the contract for data providers.
/// It uses the [http] package to make GET requests to the specified API endpoint, which is defined in the [endPoint] variable.
/// It also uses the [dotenv] package to access the API_URL environment variable.
class CategoriesProvider implements DataTypeInterface {
  static String endPoint = "/categories";

  // ignore: format-comment
  /// This function fetches categories data from the API.
  ///
  /// It returns a [Future] that completes with the body of the response as a [String].
  ///
  /// ## Example
  /// ```dart
  /// final data = await CategoriesProvider.get();
  /// ```
  static Future<String> get() async {
    http.Response res = await http.get(
      Uri.https(
        dotenv.env['API_URL']!,
        endPoint,
      ),
    );

    return res.body;
  }
}
