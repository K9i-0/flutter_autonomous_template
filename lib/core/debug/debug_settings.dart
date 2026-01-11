import 'package:freezed_annotation/freezed_annotation.dart';

part 'debug_settings.freezed.dart';
part 'debug_settings.g.dart';

/// Debug settings for development
///
/// These settings are only available in debug mode and allow
/// simulating various conditions like network delays and errors.
@freezed
sealed class DebugSettings with _$DebugSettings {
  const factory DebugSettings({
    /// Whether to use debug repository instead of real implementation
    @Default(false) bool useDebugRepository,

    /// Simulate network delay (2 seconds) for repository operations
    @Default(false) bool simulateNetworkDelay,

    /// Simulate errors for repository operations
    @Default(false) bool simulateError,

    /// Show network request logs in console
    @Default(false) bool showNetworkLogs,
  }) = _DebugSettings;

  factory DebugSettings.fromJson(Map<String, dynamic> json) =>
      _$DebugSettingsFromJson(json);
}
