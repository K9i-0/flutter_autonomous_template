import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_autonomous_template/features/settings/data/models/app_settings.dart';
import 'package:flutter_autonomous_template/features/settings/data/repositories/settings_repository.dart';
import 'package:flutter_autonomous_template/features/todo/providers/todo_provider.dart';

/// SettingsRepository provider
final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return SettingsRepository(prefs);
});

/// Provider for application settings
final settingsProvider = NotifierProvider<SettingsNotifier, AppSettings>(
  SettingsNotifier.new,
);

/// Notifier for managing settings state
class SettingsNotifier extends Notifier<AppSettings> {
  SettingsRepository get _repository => ref.read(settingsRepositoryProvider);

  @override
  AppSettings build() {
    return _repository.getSettings();
  }

  /// Update theme mode
  Future<void> setThemeMode(ThemeModeValue themeMode) async {
    await _repository.updateThemeMode(themeMode);
    state = state.copyWith(themeMode: themeMode);
  }

  /// Update locale
  Future<void> setLocale(String locale) async {
    await _repository.updateLocale(locale);
    state = state.copyWith(locale: locale);
  }
}

/// Provider for the current ThemeMode
final themeModeProvider = Provider<ThemeMode>((ref) {
  final settings = ref.watch(settingsProvider);
  return settings.themeMode.toThemeMode();
});

/// Provider for the current Locale
final localeProvider = Provider<Locale>((ref) {
  final settings = ref.watch(settingsProvider);
  return Locale(settings.locale);
});
