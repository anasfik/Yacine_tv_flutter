import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';
import 'package:yacine_tv/config/general.dart';

class Themes {
  static ThemeData? _decodedLightTheme;
  static ThemeData? get decodedLightTheme => _decodedLightTheme;

  static ThemeData get light {
    assert(decodedLightTheme != null,
        'You must call decodeThemes() before using the light theme.');

    return decodedLightTheme ?? ThemeData.light();
  }

  static Future<void> decodeThemes() async {
    await _decodeLightTheme();
  }

  static Future<void> _decodeLightTheme() async {
    dynamic decodedTheme = await rootBundle.loadString(Configs.lightThemePath);
    
    decodedTheme = json.decode(decodedTheme);
    _decodedLightTheme = ThemeDecoder.decodeThemeData(decodedTheme);
  }
}
