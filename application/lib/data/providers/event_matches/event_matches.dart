import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;

import '../../interfaces/data_type.dart';

/// This class provides match events data.
///
/// It implements the [DataTypeInterface] interface, which defines the contract for data providers.
/// It uses the [http] package to make GET requests to the specified API endpoint, which is defined in the [endPoint] variable.
/// It also uses the [dotenv] package to access the API_URL environment variable.
class MatchEventsProvider implements DataTypeInterface {
  static String endPoint = "/match_events";

  /// This function fetches match events data from the API.
  ///
  /// It returns a [Future] that completes with the body of the response as a [String].
  /// The request contains headers for Content-Type and Accept to specify that the request and response body should be in json format.
  ///
  /// # Example
  /// ```dart
  /// final data = await MatchEventsProvider.get();
  /// ```
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
}
