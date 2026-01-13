import 'package:flutter/widgets.dart';

/// Application border radius constants - Discord Style
///
/// Discord uses moderate rounding with pill-shaped buttons.
abstract class AppRadius {
  // Radius values
  static const double none = 0;
  static const double xs = 3;
  static const double sm = 4;
  static const double md = 8;
  static const double lg = 12;
  static const double xl = 16;
  static const double xxl = 20;
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
  static const BorderRadius lgTop = BorderRadius.vertical(
    top: Radius.circular(lg),
  );
  static const BorderRadius xlTop = BorderRadius.vertical(
    top: Radius.circular(xl),
  );
  static const BorderRadius xxlTop = BorderRadius.vertical(
    top: Radius.circular(xxl),
  );

  // Component-specific presets - Discord style
  static const BorderRadius button = xxlAll; // Pill-shaped buttons
  static const BorderRadius buttonSmall = smAll;
  static const BorderRadius card = mdAll; // 8px rounded cards
  static const BorderRadius cardLarge = lgAll;
  static const BorderRadius chip = fullAll; // Pill-shaped chips
  static const BorderRadius input = smAll; // Subtle input rounding
  static const BorderRadius dialog = lgAll;
  static const BorderRadius bottomSheet = xlTop;
  static const BorderRadius checkbox = BorderRadius.all(Radius.circular(6));
  static const BorderRadius fab = fullAll; // Circular FAB
  static const BorderRadius avatar = fullAll;
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
}
