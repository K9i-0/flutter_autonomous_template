import 'package:flutter/widgets.dart';

/// Application border radius constants - Timee Style
///
/// Consistent corner rounding for UI elements.
/// Timee uses 8px as standard radius with lighter rounded corners.
abstract class AppRadius {
  // Radius values - Timee style (8px standard)
  static const double none = 0;
  static const double xs = 4;
  static const double sm = 6;
  static const double md = 8;
  static const double lg = 12;
  static const double xl = 16;
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
  static const BorderRadius lgTop = BorderRadius.vertical(
    top: Radius.circular(lg),
  );
  static const BorderRadius xlTop = BorderRadius.vertical(
    top: Radius.circular(xl),
  );
  static const BorderRadius xxlTop = BorderRadius.vertical(
    top: Radius.circular(xxl),
  );

  // Component-specific presets - Timee style
  static const BorderRadius button = mdAll; // 8px - standard buttons
  static const BorderRadius buttonSmall = smAll; // 6px - small buttons
  static const BorderRadius buttonPill = fullAll; // pill shape buttons
  static const BorderRadius card = mdAll; // 8px - cards
  static const BorderRadius cardLarge = lgAll; // 12px - large cards
  static const BorderRadius chip = smAll; // 6px - chips/tags
  static const BorderRadius input = mdAll; // 8px - inputs
  static const BorderRadius dialog = lgAll; // 12px - dialogs
  static const BorderRadius bottomSheet = lgTop; // 12px top - bottom sheets
  static const BorderRadius checkbox = xsAll; // 4px - checkbox
  static const BorderRadius fab = mdAll; // 8px - FAB
  static const BorderRadius avatar = fullAll; // full - avatars
  static const BorderRadius badge = xsAll; // 4px - badges
}

/// RoundedRectangleBorder presets - Timee style
abstract class AppShapeBorder {
  static final RoundedRectangleBorder button = RoundedRectangleBorder(
    borderRadius: AppRadius.button,
  );

  static final RoundedRectangleBorder buttonSmall = RoundedRectangleBorder(
    borderRadius: AppRadius.buttonSmall,
  );

  static final RoundedRectangleBorder buttonPill = RoundedRectangleBorder(
    borderRadius: AppRadius.buttonPill,
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
}
