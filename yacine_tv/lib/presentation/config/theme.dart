import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';
import 'package:yacine_tv/config/general.dart';

class Themes {
  static ThemeData? _decodedLightTheme;

  static ThemeData? get decodedLightTheme => _decodedLightTheme;

  /// Returns the decoded light theme, or the default light theme if the decoding failed.
  static ThemeData get light {
    assert(decodedLightTheme != null,
        'You must call decodeThemes() before using the light theme.');

    return decodedLightTheme ?? ThemeData.light();
  }

  /// Decodes the class themes from the JSON.
  static Future<void> decodeThemes() async {
    await _decodeLightTheme();
  }

  /// This function decodes the light theme of the application.
  ///
  ///
  /// It loads the theme json file specified in the [Configs.lightThemePath] using the [rootBundle].
  ///
  ///
  /// Then it decodes it using the [jsonDecode] method and converts it into a [Map] of dynamic values.
  ///
  ///
  /// Finally, it uses the [ThemeDecoder.decodeThemeData] method to decode the map into a [ThemeData] object, which is assigned to the _decodedLightTheme private variable.
  ///
  ///
  static Future<void> _decodeLightTheme() async {
    String themeAssesJson = await rootBundle.loadString(Configs.lightThemePath);
    Map<String, dynamic> decodedTheme = json.decode(themeAssesJson);
    _decodedLightTheme = ThemeDecoder.decodeThemeData(decodedTheme);
  }
}
