---
name: flutter-ui-design
description: Discord-style UI design guidelines for Flutter apps. Clean, modern, and familiar design based on Discord's aesthetic.
---

# Flutter UI Design Guidelines - Discord Style

## Purpose

This skill provides guidelines to implement Discord-inspired UI design for Flutter apps. The goal is to achieve a clean, modern, and familiar look based on Discord's aesthetic.

## Design Philosophy

Discord's design emphasizes:
- **Clean and minimal**: Spacious layouts with clear visual hierarchy
- **Familiar and comfortable**: Recognizable patterns that feel natural
- **Accessible**: High contrast, readable fonts, clear interactive states
- **Consistent**: Unified visual language across all screens

## Typography

### Font Selection

```dart
// Use clean, modern sans-serif fonts
import 'package:google_fonts/google_fonts.dart';

// For titles: Bold, geometric sans-serif
GoogleFonts.outfit(fontWeight: FontWeight.w700)  // Discord-like headings
GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700)

// For body: Highly readable sans-serif
GoogleFonts.inter()  // Similar to Discord's gg sans
GoogleFonts.dmSans()

// Size hierarchy
headlineLarge: 28sp, weight: 700
headlineMedium: 24sp, weight: 600
titleLarge: 18sp, weight: 600
bodyLarge: 16sp, weight: 400
bodyMedium: 14sp, weight: 400
labelSmall: 12sp, weight: 500
```

### Font Weight Usage
- **Bold (w600-w700)** for headings and titles
- **Medium (w500)** for labels and emphasis
- **Regular (w400)** for body text

## Color Palette

### Discord Blurple Theme

```dart
// Primary - Discord Blurple
static const Color primaryLight = Color(0xFF5865F2);  // Discord Blurple
static const Color primaryDark = Color(0xFF7289DA);   // Lighter for dark mode

// Secondary - Discord Green (for success states)
static const Color secondaryLight = Color(0xFF3BA55C);
static const Color secondaryDark = Color(0xFF57F287);

// Error - Discord Red
static const Color errorLight = Color(0xFFED4245);
static const Color errorDark = Color(0xFFF04747);

// Warning - Discord Yellow
static const Color warningLight = Color(0xFFFAA61A);
static const Color warningDark = Color(0xFFFEE75C);

// Surface colors - Light theme
static const Color surfaceLight = Color(0xFFFFFFFF);           // Pure white
static const Color surfaceContainerLight = Color(0xFFF2F3F5);  // Light gray
static const Color surfaceContainerHighLight = Color(0xFFEBEDEF);

// Surface colors - Dark theme
static const Color surfaceDark = Color(0xFF313338);            // Discord dark
static const Color surfaceContainerDark = Color(0xFF2B2D31);
static const Color surfaceContainerHighDark = Color(0xFF1E1F22);

// Text colors
static const Color onSurfaceLight = Color(0xFF2E3338);         // Dark gray
static const Color onSurfaceVariantLight = Color(0xFF6D6F78);  // Medium gray
static const Color onSurfaceDark = Color(0xFFDBDEE1);          // Light gray
static const Color onSurfaceVariantDark = Color(0xFF949BA4);   // Muted gray
```

### Color Usage Guidelines
- **Blurple** for primary actions, links, and selected states
- **Green** for success indicators and positive actions
- **Red** for destructive actions and errors
- **Gray tones** for backgrounds and surfaces
- High contrast text on all backgrounds

## Border Radius

### Discord-style Radius Values

```dart
// Discord uses moderate rounding
abstract class AppRadius {
  static const double none = 0;
  static const double xs = 3;    // Very subtle
  static const double sm = 4;    // Input fields, small buttons
  static const double md = 8;    // Cards, dialogs
  static const double lg = 12;   // Large cards
  static const double xl = 16;   // Bottom sheets
  static const double xxl = 20;  // Primary buttons (pill-shaped)
  static const double full = 9999;  // Circular (avatars, FAB)

  // Component-specific
  static const BorderRadius button = BorderRadius.all(Radius.circular(xxl));  // Pill-shaped
  static const BorderRadius buttonSmall = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius input = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius card = BorderRadius.all(Radius.circular(md));
  static const BorderRadius chip = BorderRadius.all(Radius.circular(full));  // Pill chips
  static const BorderRadius fab = BorderRadius.all(Radius.circular(full));   // Circular FAB
}
```

## Components

### Buttons

```dart
// Primary button - Pill-shaped, Blurple
FilledButton(
  style: FilledButton.styleFrom(
    backgroundColor: Color(0xFF5865F2),
    foregroundColor: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),  // Pill-shaped
    ),
    textStyle: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14,
    ),
  ),
  child: Text('Button'),
)

// Secondary/Outline button
OutlinedButton(
  style: OutlinedButton.styleFrom(
    foregroundColor: Color(0xFF5865F2),
    side: BorderSide.none,  // Discord often uses borderless secondary buttons
    backgroundColor: Color(0xFFF2F3F5),
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  ),
)
```

### Input Fields

```dart
// Discord-style input - Subtle, filled background
TextField(
  decoration: InputDecoration(
    filled: true,
    fillColor: Color(0xFFE3E5E8),  // Slightly darker than surface
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: Color(0xFF5865F2), width: 2),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    hintStyle: TextStyle(color: Color(0xFF6D6F78)),
  ),
)
```

### Cards

```dart
// Discord-style card - Clean, minimal elevation
Card(
  elevation: 0,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
  ),
  color: Color(0xFFF2F3F5),  // Light gray surface
  child: Padding(
    padding: EdgeInsets.all(16),
    child: ...
  ),
)
```

### Chips / Tags

```dart
// Discord-style chip - Pill-shaped
Chip(
  label: Text('Tag'),
  backgroundColor: Color(0xFFE3E5E8),
  labelStyle: TextStyle(
    color: Color(0xFF2E3338),
    fontSize: 12,
    fontWeight: FontWeight.w500,
  ),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),  // Pill shape
    side: BorderSide.none,
  ),
  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
)

// Selected chip
Chip(
  label: Text('Selected'),
  backgroundColor: Color(0xFF5865F2).withOpacity(0.15),
  labelStyle: TextStyle(
    color: Color(0xFF5865F2),
    fontWeight: FontWeight.w600,
  ),
)
```

### Checkboxes

```dart
// Discord-style checkbox - Rounded square
CheckboxThemeData(
  fillColor: WidgetStateProperty.resolveWith((states) {
    if (states.contains(WidgetState.selected)) {
      return Color(0xFF5865F2);  // Blurple when checked
    }
    return Colors.transparent;
  }),
  checkColor: WidgetStateProperty.all(Colors.white),
  side: BorderSide(color: Color(0xFFB5BAC1), width: 2),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(6),  // Rounded square
  ),
)
```

### Navigation Bar

```dart
// Discord-style bottom navigation
NavigationBarThemeData(
  elevation: 0,
  backgroundColor: Colors.white,
  indicatorColor: Color(0xFF5865F2).withOpacity(0.15),
  labelTextStyle: WidgetStateProperty.resolveWith((states) {
    if (states.contains(WidgetState.selected)) {
      return TextStyle(
        color: Color(0xFF5865F2),
        fontWeight: FontWeight.w600,
        fontSize: 12,
      );
    }
    return TextStyle(
      color: Color(0xFF6D6F78),
      fontWeight: FontWeight.w500,
      fontSize: 12,
    );
  }),
)
```

## Spacing

### Discord-style Spacing System

```dart
// Based on 4px grid (Discord uses 4px increments)
const spacing = (
  xxs: 2.0,
  xs: 4.0,
  sm: 8.0,
  md: 12.0,
  lg: 16.0,
  xl: 20.0,
  xxl: 24.0,
  xxxl: 32.0,
);

// Generous padding for comfortable touch targets
// Button padding: 14-16px vertical, 24px horizontal
// Card padding: 16px all around
// Screen margin: 16px horizontal
```

## Layout Principles

### Discord-style Layout

1. **Clean headers**: Simple, bold titles with minimal decoration
2. **Card-based content**: Group related items in subtle cards
3. **Spacious lists**: Generous vertical spacing between items
4. **Clear visual hierarchy**: Size and weight differentiate importance
5. **Minimal dividers**: Use spacing over lines when possible

## Interactive States

### Feedback Patterns

```dart
// Hover/press state - Subtle background change
InkWell(
  borderRadius: BorderRadius.circular(8),
  onTap: () {},
  child: Container(
    padding: EdgeInsets.all(12),
    child: ...
  ),
)

// Selected state - Blurple tint
Container(
  decoration: BoxDecoration(
    color: Color(0xFF5865F2).withOpacity(0.1),
    borderRadius: BorderRadius.circular(8),
  ),
)
```

## Checklist

When implementing Discord-style UI:

- [ ] Using clean sans-serif fonts (Inter, Outfit, DM Sans)
- [ ] Primary color is Discord Blurple (#5865F2)
- [ ] Buttons have pill-shaped corners (20px radius)
- [ ] Input fields have subtle rounded corners (4px)
- [ ] Cards use light gray backgrounds, no borders
- [ ] Chips are pill-shaped (full radius)
- [ ] Checkboxes are rounded squares
- [ ] Spacing follows 4px grid
- [ ] High contrast text on all surfaces
- [ ] Interactive states provide clear feedback
