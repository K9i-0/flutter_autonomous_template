import 'package:flutter/widgets.dart';

/// Application spacing constants
///
/// Based on 8px grid system for consistent spacing throughout the app.
abstract class AppSpacing {
  // Base spacing values (8px grid)
  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
  static const double xxxl = 64;

  // Screen padding
  static const EdgeInsets screenPadding = EdgeInsets.all(md);
  static const EdgeInsets screenPaddingHorizontal = EdgeInsets.symmetric(
    horizontal: md,
  );

  // Card padding
  static const EdgeInsets cardPadding = EdgeInsets.all(md);
  static const EdgeInsets cardPaddingLarge = EdgeInsets.all(lg);
  static const EdgeInsets cardPaddingSmall = EdgeInsets.all(sm);

  // List item padding
  static const EdgeInsets listItemPadding = EdgeInsets.symmetric(
    horizontal: md,
    vertical: sm,
  );

  // Button padding
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    horizontal: lg,
    vertical: md,
  );
  static const EdgeInsets buttonPaddingSmall = EdgeInsets.symmetric(
    horizontal: md,
    vertical: sm,
  );

  // Input padding
  static const EdgeInsets inputPadding = EdgeInsets.symmetric(
    horizontal: md,
    vertical: md,
  );

  // Section gap (vertical spacing between sections)
  static const double sectionGap = lg;
  static const double sectionGapLarge = xl;

  // Item gap (spacing between items in a list or row)
  static const double itemGap = sm;
  static const double itemGapLarge = md;

  // Icon spacing
  static const double iconTextGap = sm;

  // Dialog padding
  static const EdgeInsets dialogPadding = EdgeInsets.all(lg);

  // Bottom sheet padding
  static const EdgeInsets bottomSheetPadding = EdgeInsets.fromLTRB(
    md,
    md,
    md,
    lg,
  );
}

/// Gap widgets for convenience
class Gap extends StatelessWidget {
  const Gap(this.size, {super.key});

  final double size;

  /// Extra extra small gap (2px)
  const Gap.xxs({super.key}) : size = AppSpacing.xxs;

  /// Extra small gap (4px)
  const Gap.xs({super.key}) : size = AppSpacing.xs;

  /// Small gap (8px)
  const Gap.sm({super.key}) : size = AppSpacing.sm;

  /// Medium gap (16px)
  const Gap.md({super.key}) : size = AppSpacing.md;

  /// Large gap (24px)
  const Gap.lg({super.key}) : size = AppSpacing.lg;

  /// Extra large gap (32px)
  const Gap.xl({super.key}) : size = AppSpacing.xl;

  /// Extra extra large gap (48px)
  const Gap.xxl({super.key}) : size = AppSpacing.xxl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: size, height: size);
  }
}

/// Horizontal gap widget
class HGap extends StatelessWidget {
  const HGap(this.width, {super.key});

  final double width;

  const HGap.xxs({super.key}) : width = AppSpacing.xxs;
  const HGap.xs({super.key}) : width = AppSpacing.xs;
  const HGap.sm({super.key}) : width = AppSpacing.sm;
  const HGap.md({super.key}) : width = AppSpacing.md;
  const HGap.lg({super.key}) : width = AppSpacing.lg;
  const HGap.xl({super.key}) : width = AppSpacing.xl;
  const HGap.xxl({super.key}) : width = AppSpacing.xxl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}

/// Vertical gap widget
class VGap extends StatelessWidget {
  const VGap(this.height, {super.key});

  final double height;

  const VGap.xxs({super.key}) : height = AppSpacing.xxs;
  const VGap.xs({super.key}) : height = AppSpacing.xs;
  const VGap.sm({super.key}) : height = AppSpacing.sm;
  const VGap.md({super.key}) : height = AppSpacing.md;
  const VGap.lg({super.key}) : height = AppSpacing.lg;
  const VGap.xl({super.key}) : height = AppSpacing.xl;
  const VGap.xxl({super.key}) : height = AppSpacing.xxl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}
