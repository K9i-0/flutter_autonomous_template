/// Product Flavor for environment separation
///
/// Usage with dart-define:
/// ```bash
/// flutter run --dart-define=flavor=dev
/// flutter build apk --dart-define=flavor=prd
/// ```
enum Flavor {
  /// Development environment
  dev,

  /// Staging environment
  stg,

  /// Production environment
  prd,
}
