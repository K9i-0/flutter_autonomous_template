import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_autonomous_template/features/settings/data/models/app_settings.dart';

/// Repository for managing application settings persistence
class SettingsRepository {
  SettingsRepository(this._prefs);

  final SharedPreferences _prefs;
  static const _settingsKey = 'app_settings';

  /// Get current settings
  AppSettings getSettings() {
    final jsonString = _prefs.getString(_settingsKey);
    if (jsonString == null) return const AppSettings();

    try {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return AppSettings.fromJson(json);
    } catch (e) {
      return const AppSettings();
    }
  }

  /// Save settings
  Future<void> saveSettings(AppSettings settings) async {
    final jsonString = jsonEncode(settings.toJson());
    await _prefs.setString(_settingsKey, jsonString);
  }

  /// Update theme mode
  Future<void> updateThemeMode(ThemeModeValue themeMode) async {
    final settings = getSettings();
    await saveSettings(settings.copyWith(themeMode: themeMode));
  }

  /// Update locale
  Future<void> updateLocale(String locale) async {
    final settings = getSettings();
    await saveSettings(settings.copyWith(locale: locale));
  }
}
