import 'package:flutter/widgets.dart';

/// Application border radius constants
///
/// Consistent corner rounding for UI elements.
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
  static const BorderRadius lgTop = BorderRadius.vertical(
    top: Radius.circular(lg),
  );
  static const BorderRadius xlTop = BorderRadius.vertical(
    top: Radius.circular(xl),
  );
  static const BorderRadius xxlTop = BorderRadius.vertical(
    top: Radius.circular(xxl),
  );

  // Component-specific presets
  static const BorderRadius button = mdAll;
  static const BorderRadius buttonSmall = smAll;
  static const BorderRadius card = lgAll;
  static const BorderRadius cardLarge = xlAll;
  static const BorderRadius chip = smAll;
  static const BorderRadius input = mdAll;
  static const BorderRadius dialog = xlAll;
  static const BorderRadius bottomSheet = xlTop;
  static const BorderRadius checkbox = xsAll;
  static const BorderRadius fab = lgAll;
  static const BorderRadius avatar = fullAll;

  // Discord-specific presets
  static const double pill = 24;
  static const BorderRadius pillAll = BorderRadius.all(Radius.circular(pill));
  static const BorderRadius discordInput = smAll;
  static const BorderRadius discordCard = mdAll;
  static const BorderRadius discordSheet = BorderRadius.vertical(
    top: Radius.circular(lg),
  );
  static const BorderRadius discordBadge = xsAll;
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
