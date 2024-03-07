import 'dart:convert';

import '../../models/app_settings.dart';
import '../../providers/settings/app_settings.dart';

class SettingsRepository {
  SettingsRepository();

  Future<AppSettings?> getSettings() async {
    final resBody = await SettingsProvider.get();
    final res = jsonDecode(resBody) as Map<String, dynamic>;
    final data = res["data"];

    if (data == null) {
      return null;
    }

    final result = AppSettings.fromMap(Map.from(data));

    return result;
  }

  Future updateSettings(AppSettings settings) async {
    final res = await SettingsProvider.put(settings);
    print(res);
  }
}
