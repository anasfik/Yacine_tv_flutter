import 'package:flutter_dotenv/flutter_dotenv.dart';

class Core {
  /// Initializes environment variables from a file named ".env".
  ///
  /// This method uses the [dotenv] package to asynchronously load environment
  /// variables from a file named ".env" in the root directory of the project.
  ///
  /// Example:
  /// ```
  /// await init();
  /// ```
  static Future<void> init() async {
    await dotenv.load(fileName: "env");
    print(dotenv.env['API_URL']!);
  }
}
