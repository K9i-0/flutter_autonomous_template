import 'package:freezed_annotation/freezed_annotation.dart';

part 'debug_settings.freezed.dart';
part 'debug_settings.g.dart';

/// Debug settings for development
///
/// These settings are only available in debug mode.
@freezed
sealed class DebugSettings with _$DebugSettings {
  const factory DebugSettings({
    /// Whether to use debug repository with dummy data
    @Default(false) bool useDebugRepository,
  }) = _DebugSettings;

  factory DebugSettings.fromJson(Map<String, dynamic> json) =>
      _$DebugSettingsFromJson(json);
}
