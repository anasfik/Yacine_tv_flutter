import 'dart:convert';

import '../../models/app_settings.dart';
import '../../providers/settings/settings.dart';

class SettingsRepository {
  SettingsRepository();

  Future<AppSettings> getSettings() async {
    final resBody = await SettingsProvider.get();
    final res = jsonDecode(resBody) as Map<String, dynamic>;
    final result = AppSettings.fromMap(Map.from(res["data"]));

    return result;
  }
}
