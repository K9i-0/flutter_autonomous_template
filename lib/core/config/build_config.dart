// NOTE: This file centralizes `~.fromEnvironment()` calls
// ignore_for_file: do_not_use_environment

import 'package:flutter_autonomous_template/core/config/flavor.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'build_config.freezed.dart';

/// Build configuration from dart-define environment variables
///
/// Usage:
/// ```dart
/// final config = BuildConfig.fromEnvironment();
/// print(config.flavor); // dev, stg, or prd
/// ```
@Freezed(map: FreezedMapOptions.none, when: FreezedWhenOptions.none)
abstract class BuildConfig with _$BuildConfig {
  const BuildConfig._();

  const factory BuildConfig({
    required Flavor flavor,
    required String appName,
    required String baseUrl,
  }) = _BuildConfig;

  /// Create BuildConfig from dart-define environment variables
  ///
  /// Run with:
  /// ```bash
  /// flutter run --dart-define=flavor=dev
  /// ```
  factory BuildConfig.fromEnvironment() {
    const flavorStr = String.fromEnvironment('flavor', defaultValue: 'dev');
    final flavor = Flavor.values.byName(flavorStr);

    return BuildConfig(
      flavor: flavor,
      appName: _appName(flavor),
      baseUrl: _baseUrl(flavor),
    );
  }

  /// Check if current flavor is development
  bool get isDev => flavor == Flavor.dev;

  /// Check if current flavor is staging
  bool get isStg => flavor == Flavor.stg;

  /// Check if current flavor is production
  bool get isPrd => flavor == Flavor.prd;

  static String _appName(Flavor flavor) {
    return switch (flavor) {
      Flavor.dev => 'App (Dev)',
      Flavor.stg => 'App (Stg)',
      Flavor.prd => 'App',
    };
  }

  static String _baseUrl(Flavor flavor) {
    return switch (flavor) {
      Flavor.dev => 'https://api-dev.example.com',
      Flavor.stg => 'https://api-stg.example.com',
      Flavor.prd => 'https://api.example.com',
    };
  }
}
