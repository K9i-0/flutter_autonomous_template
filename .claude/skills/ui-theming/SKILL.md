---
name: ui-theming
description: "UI theming skill for applying brand designs to Flutter apps. Use when user asks to 'apply X style', 'change theme to Y', 'make it look like Z', or provides reference images for UI design."
---

# UI Theming Skill

## Purpose

Apply brand-specific or reference-based UI designs to Flutter apps. This skill guides the process from analyzing reference images to implementing a cohesive design system.

## Workflow Overview

```
1. Analyze Reference → 2. Extract Design System → 3. Implement Theme → 4. Layout Changes → 5. Verify
```

---

## Phase 1: Analyze Reference Images

When the user provides reference images or mentions a brand style:

### Extract from Images
1. **Color Palette** - Primary, secondary, accent, background, surface colors
2. **Typography** - Font families, weights, sizes
3. **Border Radius** - Buttons, cards, inputs, badges
4. **Component Patterns** - Buttons, cards, badges, banners, FAB styles
5. **Spacing** - Padding, margins, gaps

### Document Findings
Create a design specification table:

```markdown
| Element | Light Mode | Dark Mode | Notes |
|---------|-----------|-----------|-------|
| Primary | #XXXXXX | #XXXXXX | Main action color |
| Secondary | #XXXXXX | #XXXXXX | Accent color |
| Background | #FFFFFF | #1A1A1A | App background |
| Surface | #F8F8F8 | #2D2D2D | Card background |
```

---

## Phase 2: Implement Theme Files

### File Structure

```
lib/core/theme/
├── app_colors.dart      # Color palette & ColorScheme
├── app_typography.dart  # Font families & TextTheme
├── app_radius.dart      # BorderRadius presets
├── app_spacing.dart     # Spacing constants
└── app_theme.dart       # ThemeData integration
```

### app_colors.dart Pattern

```dart
import 'package:flutter/material.dart';

/// Brand color palette
class AppColors {
  // Primary colors
  static const Color primaryLight = Color(0xFFXXXXXX);
  static const Color primaryDark = Color(0xFFXXXXXX);

  // Secondary colors
  static const Color secondaryLight = Color(0xFFXXXXXX);
  static const Color secondaryDark = Color(0xFFXXXXXX);

  // Supporting colors
  static const Color errorLight = Color(0xFFDC3545);
  static const Color successLight = Color(0xFF28A745);
}

/// ColorScheme builder
class AppColorScheme {
  static ColorScheme lightScheme() {
    return ColorScheme.light(
      primary: AppColors.primaryLight,
      secondary: AppColors.secondaryLight,
      // ... other colors
    );
  }

  static ColorScheme darkScheme() {
    return ColorScheme.dark(
      primary: AppColors.primaryDark,
      secondary: AppColors.secondaryDark,
      // ... other colors
    );
  }
}
```

### app_typography.dart Pattern

```dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  // Font families
  static String get headlineFont => GoogleFonts.poppins().fontFamily!;
  static String get bodyFont => GoogleFonts.nunitoSans().fontFamily!;

  static TextTheme buildTextTheme(ColorScheme colorScheme) {
    return TextTheme(
      headlineLarge: GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: colorScheme.onSurface,
      ),
      // ... other text styles
    );
  }
}
```

### app_radius.dart Pattern

```dart
import 'package:flutter/material.dart';

class AppRadius {
  // Base values
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;

  // Component-specific presets
  static const BorderRadius button = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius card = BorderRadius.all(Radius.circular(md));
  static const BorderRadius input = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius badge = BorderRadius.all(Radius.circular(xs));
  static const BorderRadius fab = BorderRadius.all(Radius.circular(100));
}
```

### app_theme.dart Pattern

```dart
class AppTheme {
  static ThemeData get lightTheme {
    final colorScheme = AppColorScheme.lightScheme();
    return _buildTheme(colorScheme, Brightness.light);
  }

  static ThemeData get darkTheme {
    final colorScheme = AppColorScheme.darkScheme();
    return _buildTheme(colorScheme, Brightness.dark);
  }

  static ThemeData _buildTheme(ColorScheme colorScheme, Brightness brightness) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      // Component themes...
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.secondary,
        foregroundColor: colorScheme.onSecondary,
      ),
      // ... other component themes
    );
  }
}
```

---

## Phase 3: Layout Changes

Beyond theme colors, consider these layout enhancements:

### Promotional Banners

```dart
Container(
  padding: EdgeInsets.all(16),
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [
        colorScheme.secondary,
        colorScheme.secondary.withOpacity(0.8),
      ],
    ),
    borderRadius: BorderRadius.circular(8),
  ),
  child: Row(
    children: [
      Icon(Icons.local_offer),
      // Content...
    ],
  ),
)
```

### Priority Badges

```dart
Container(
  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  decoration: BoxDecoration(
    color: badgeColor.withOpacity(0.1),
    borderRadius: BorderRadius.circular(4),
  ),
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(badgeIcon, size: 14, color: badgeColor),
      SizedBox(width: 4),
      Text(badgeText, style: TextStyle(color: badgeColor)),
    ],
  ),
)
```

### Section Cards with Left Border Accent

```dart
Container(
  decoration: BoxDecoration(
    color: colorScheme.surface,
    borderRadius: BorderRadius.circular(12),
    border: Border(
      left: BorderSide(color: accentColor, width: 4),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.06),
        blurRadius: 8,
        offset: Offset(0, 2),
      ),
    ],
  ),
)
```

---

## Phase 4: Verification

### Testing Checklist

1. **Light Theme**
   - [ ] Colors match reference
   - [ ] Typography is correct
   - [ ] Border radius is consistent
   - [ ] Component styles match

2. **Dark Theme**
   - [ ] Colors adapt correctly
   - [ ] Contrast is sufficient
   - [ ] No hard-coded colors

3. **Components**
   - [ ] Buttons (primary, secondary, text)
   - [ ] Cards and surfaces
   - [ ] Input fields
   - [ ] FAB
   - [ ] Badges/tags
   - [ ] Navigation

### Screenshot Workflow

```
1. Dart MCP: launch_app
2. Dart MCP: connect_dart_tooling_daemon
3. Navigate to each screen
4. Maestro: take_screenshot
5. Compare with reference
```

---

## Common Patterns

### Brand Style Examples

| Brand Style | Primary | Secondary | Radius | Typography |
|-------------|---------|-----------|--------|------------|
| McDonald's | Red #DA291C | Yellow #FFC72C | 8-12px | Poppins + Nunito Sans |
| Discord | Blurple #5865F2 | Green #57F287 | Pill (full) | gg sans |
| Material You | Dynamic | Dynamic | 12-28px | Roboto |

### Google Fonts Pairings

| Style | Headlines | Body |
|-------|-----------|------|
| Modern | Poppins | Nunito Sans |
| Classic | Playfair Display | Source Sans Pro |
| Tech | Inter | Inter |
| Friendly | Nunito | Open Sans |

---

## Tips

1. **Start with colors** - They have the biggest visual impact
2. **Use ColorScheme** - Material 3 handles light/dark automatically
3. **Consistent radius** - Pick 2-3 values and stick with them
4. **Test both themes** - Implement light and dark from the start
5. **Layout last** - Change component layouts after theme is stable
