import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';

import '../../config/general.dart';

class Themes {
  static ThemeData? _lightTheme;

  static ThemeData? get lightTheme => _lightTheme;

  /// Returns the decoded light theme, or the default light theme if the decoding failed.
  static ThemeData get light {
    return _lightTheme ?? ThemeData.light();
  }

  /// Decodes the themes from the JSON.
  static Future<void> decodeThemes() async {
    _lightTheme = await _loadAndDecodeLightTheme();
  }

  ///  This function loads the theme json file specified in the [Configs.lightThemePath] using the [rootBundle].
  ///
  /// Then it decodes it using the [jsonDecode] method and converts it into a [Map] of dynamic values.
  ///
  /// Finally, it uses the [ThemeDecoder.decodeThemeData] method to decode the map into a [ThemeData] object, which is returned.
  ///
  static Future<ThemeData?> _loadAndDecodeLightTheme() async {
    String themeAssesJson = await rootBundle.loadString(Configs.lightThemePath);
    Map<String, dynamic> decodedTheme = json.decode(themeAssesJson);

    return ThemeDecoder.decodeThemeData(decodedTheme);
  }
}
