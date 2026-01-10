import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings.freezed.dart';
part 'app_settings.g.dart';

/// Application settings model
@freezed
sealed class AppSettings with _$AppSettings {
  const factory AppSettings({
    @Default(ThemeModeValue.system) ThemeModeValue themeMode,
    @Default('en') String locale,
  }) = _AppSettings;

  factory AppSettings.fromJson(Map<String, dynamic> json) =>
      _$AppSettingsFromJson(json);
}

/// Theme mode values (serializable version of ThemeMode)
enum ThemeModeValue {
  system,
  light,
  dark;

  ThemeMode toThemeMode() {
    switch (this) {
      case ThemeModeValue.system:
        return ThemeMode.system;
      case ThemeModeValue.light:
        return ThemeMode.light;
      case ThemeModeValue.dark:
        return ThemeMode.dark;
    }
  }

  static ThemeModeValue fromThemeMode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return ThemeModeValue.system;
      case ThemeMode.light:
        return ThemeModeValue.light;
      case ThemeMode.dark:
        return ThemeModeValue.dark;
    }
  }
}
