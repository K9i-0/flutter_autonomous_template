import 'package:flutter/widgets.dart';

/// Application border radius constants - McDonald's Style
///
/// McDonald's uses moderate, friendly rounding (8-12px typically).
abstract class AppRadius {
  // Radius values
  static const double none = 0;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double full = 9999;

  // BorderRadius presets
  static const BorderRadius zero = BorderRadius.zero;

  static const BorderRadius xsAll = BorderRadius.all(Radius.circular(xs));
  static const BorderRadius smAll = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius mdAll = BorderRadius.all(Radius.circular(md));
  static const BorderRadius lgAll = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius xlAll = BorderRadius.all(Radius.circular(xl));
  static const BorderRadius xxlAll = BorderRadius.all(Radius.circular(xxl));
  static const BorderRadius fullAll = BorderRadius.all(Radius.circular(full));

  // Top-only radius (for bottom sheets, modals)
  static const BorderRadius mdTop = BorderRadius.vertical(
    top: Radius.circular(md),
  );
  static const BorderRadius lgTop = BorderRadius.vertical(
    top: Radius.circular(lg),
  );
  static const BorderRadius xlTop = BorderRadius.vertical(
    top: Radius.circular(xl),
  );

  // Component-specific presets - McDonald's style
  static const BorderRadius button = smAll; // 8px - moderate rounding
  static const BorderRadius buttonSmall = xsAll; // 4px
  static const BorderRadius card = mdAll; // 12px - card rounding
  static const BorderRadius cardLarge = lgAll; // 16px
  static const BorderRadius chip = smAll; // 8px
  static const BorderRadius input = smAll; // 8px - input rounding
  static const BorderRadius dialog = mdAll; // 12px
  static const BorderRadius bottomSheet = lgTop; // 16px top
  static const BorderRadius checkbox = xsAll; // 4px
  static const BorderRadius fab = fullAll; // Circular FAB
  static const BorderRadius avatar = fullAll; // Circular avatar
  static const BorderRadius badge = xsAll; // 4px for badges/tags
  static const BorderRadius banner = smAll; // 8px for promotional banners
}

/// RoundedRectangleBorder presets
abstract class AppShapeBorder {
  static final RoundedRectangleBorder button = RoundedRectangleBorder(
    borderRadius: AppRadius.button,
  );

  static final RoundedRectangleBorder buttonSmall = RoundedRectangleBorder(
    borderRadius: AppRadius.buttonSmall,
  );

  static final RoundedRectangleBorder card = RoundedRectangleBorder(
    borderRadius: AppRadius.card,
  );

  static final RoundedRectangleBorder cardLarge = RoundedRectangleBorder(
    borderRadius: AppRadius.cardLarge,
  );

  static final RoundedRectangleBorder chip = RoundedRectangleBorder(
    borderRadius: AppRadius.chip,
  );

  static final RoundedRectangleBorder input = RoundedRectangleBorder(
    borderRadius: AppRadius.input,
  );

  static final RoundedRectangleBorder dialog = RoundedRectangleBorder(
    borderRadius: AppRadius.dialog,
  );

  static final RoundedRectangleBorder fab = RoundedRectangleBorder(
    borderRadius: AppRadius.fab,
  );

  static final RoundedRectangleBorder badge = RoundedRectangleBorder(
    borderRadius: AppRadius.badge,
  );

  static final RoundedRectangleBorder banner = RoundedRectangleBorder(
    borderRadius: AppRadius.banner,
  );
}
