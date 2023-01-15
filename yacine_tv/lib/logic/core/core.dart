import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../config/general.dart';

class Core {
  static Future<void> init() async {
    // Load the environment variables.
    await dotenv.load(fileName: Configs.environmentFilePath);
  }
}
