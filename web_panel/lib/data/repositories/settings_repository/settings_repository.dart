class SettingsRepository {
  SettingsRepository();

  AppSettings getSettings() async {
    final res = await SettingsProvider.get();
    print(res);
  }
}
