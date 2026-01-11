import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_autonomous_template/core/debug/debug_settings.dart';
import 'package:flutter_autonomous_template/features/todo/providers/todo_provider.dart';

/// Provider for debug settings
final debugSettingsProvider =
    NotifierProvider<DebugSettingsNotifier, DebugSettings>(
  DebugSettingsNotifier.new,
);

/// Notifier for managing debug settings state
class DebugSettingsNotifier extends Notifier<DebugSettings> {
  static const _debugSettingsKey = 'debug_settings';

  SharedPreferences get _prefs => ref.read(sharedPreferencesProvider);

  @override
  DebugSettings build() {
    return _loadSettings();
  }

  DebugSettings _loadSettings() {
    final jsonString = _prefs.getString(_debugSettingsKey);
    if (jsonString == null) return const DebugSettings();

    try {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return DebugSettings.fromJson(json);
    } catch (_) {
      return const DebugSettings();
    }
  }

  Future<void> _saveSettings(DebugSettings settings) async {
    final jsonString = jsonEncode(settings.toJson());
    await _prefs.setString(_debugSettingsKey, jsonString);
  }

  /// Toggle debug repository usage
  Future<void> toggleUseDebugRepository() async {
    state = state.copyWith(useDebugRepository: !state.useDebugRepository);
    await _saveSettings(state);
  }

  /// Toggle network delay simulation
  Future<void> toggleSimulateNetworkDelay() async {
    state = state.copyWith(simulateNetworkDelay: !state.simulateNetworkDelay);
    await _saveSettings(state);
  }

  /// Toggle error simulation
  Future<void> toggleSimulateError() async {
    state = state.copyWith(simulateError: !state.simulateError);
    await _saveSettings(state);
  }

  /// Toggle network logs
  Future<void> toggleShowNetworkLogs() async {
    state = state.copyWith(showNetworkLogs: !state.showNetworkLogs);
    await _saveSettings(state);
  }

  /// Reset all debug settings to defaults
  Future<void> resetToDefaults() async {
    state = const DebugSettings();
    await _saveSettings(state);
  }
}
