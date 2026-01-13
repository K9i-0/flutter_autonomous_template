---
name: flutter-ui-design
description: Antique/Vintage UI design guidelines for Flutter apps. Achieve warm, classic visuals inspired by old manuscripts and wood.
---

# Flutter UI Design Guidelines - Antique Theme

## Purpose

This skill provides guidelines to create an antique/vintage aesthetic Flutter app UI, inspired by old parchment, dark wood, and brass accents.

## Design Concept

**Theme**: Classic study room / Old library aesthetic
- Parchment paper textures
- Dark wood tones
- Brass/bronze metallic accents
- Serif typography with classic elegance

## Typography

### Font Selection

```dart
// Use classic serif fonts with Google Fonts
import 'package:google_fonts/google_fonts.dart';

// For titles: Elegant serif fonts
GoogleFonts.playfairDisplay(fontWeight: FontWeight.w700)
GoogleFonts.merriweather(fontWeight: FontWeight.w700)
GoogleFonts.lora(fontWeight: FontWeight.w600)

// For body: Readable serif
GoogleFonts.sourceSerif4()
GoogleFonts.crimsonText()
GoogleFonts.libreBaskerville()

// Size hierarchy
headlineLarge: 32sp, weight: 700
headlineMedium: 24sp, weight: 600
titleLarge: 20sp, weight: 600
bodyLarge: 16sp, weight: 400
labelSmall: 12sp, weight: 500
```

### Typography Guidelines
- Use serif fonts for elegance and classic feel
- Avoid ultra-thin weights; prefer medium to bold
- Letter spacing slightly wider for readability

## Color & Theme

### Antique Color Palette

```dart
// Light theme: Parchment + Dark wood accents
ColorScheme.light(
  // Surfaces - Parchment/cream tones
  surface: Color(0xFFF5E6C8),              // Warm parchment
  surfaceContainerLowest: Color(0xFFFAF3E0), // Light cream
  surfaceContainerLow: Color(0xFFF5E6C8),
  surfaceContainer: Color(0xFFEDE0C8),      // Medium parchment
  surfaceContainerHigh: Color(0xFFE5D4B5),
  surfaceContainerHighest: Color(0xFFD4C4A0), // Aged paper

  // Primary - Dark wood/sepia
  primary: Color(0xFF5D4037),               // Dark brown
  onPrimary: Color(0xFFFAF3E0),
  primaryContainer: Color(0xFF8D6E63),
  onPrimaryContainer: Color(0xFFFAF3E0),

  // Secondary - Brass/gold accents
  secondary: Color(0xFFB8860B),             // Dark goldenrod
  onSecondary: Color(0xFFFAF3E0),
  secondaryContainer: Color(0xFFD4AF37),    // Brass gold
  onSecondaryContainer: Color(0xFF3E2723),

  // Tertiary - Deep burgundy
  tertiary: Color(0xFF6D1E1E),              // Burgundy
  onTertiary: Color(0xFFFAF3E0),

  // Outline and text
  outline: Color(0xFF8D7355),               // Muted brown
  outlineVariant: Color(0xFFB8A080),
  onSurface: Color(0xFF3E2723),             // Dark brown text
  onSurfaceVariant: Color(0xFF5D4037),
)
```

### Color Usage Points
- **Background**: Warm parchment tones (cream, beige)
- **Primary actions**: Dark wood brown
- **Accents**: Brass/gold for highlights
- **Text**: Dark sepia/brown for warmth

## Elevation & Depth

### Antique Style Depth

```dart
// Cards with parchment feel
Card(
  elevation: 0,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
    side: BorderSide(
      color: Color(0xFF8D7355).withOpacity(0.3),
      width: 1,
    ),
  ),
  color: Color(0xFFF5E6C8),
  child: ...
)

// Subtle aged shadow
BoxDecoration(
  borderRadius: BorderRadius.circular(8),
  color: Color(0xFFF5E6C8),
  boxShadow: [
    BoxShadow(
      color: Color(0xFF5D4037).withOpacity(0.08),
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
  ],
)

// Inset/embossed effect for inputs
BoxDecoration(
  borderRadius: BorderRadius.circular(8),
  color: Color(0xFFEDE0C8),
  border: Border.all(
    color: Color(0xFF8D7355).withOpacity(0.4),
    width: 1,
  ),
)
```

## Components

### Buttons

```dart
// Primary button: Brass/dark wood style
FilledButton(
  style: FilledButton.styleFrom(
    backgroundColor: Color(0xFF5D4037),
    foregroundColor: Color(0xFFFAF3E0),
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    elevation: 1,
  ),
  child: Text('Action'),
)

// Secondary button: Brass outline
OutlinedButton(
  style: OutlinedButton.styleFrom(
    foregroundColor: Color(0xFF5D4037),
    side: BorderSide(color: Color(0xFFB8860B), width: 1.5),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
)
```

### Input Fields

```dart
TextField(
  decoration: InputDecoration(
    filled: true,
    fillColor: Color(0xFFEDE0C8),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Color(0xFF8D7355)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Color(0xFF8D7355).withOpacity(0.5)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: Color(0xFF5D4037),
        width: 2,
      ),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    labelStyle: TextStyle(color: Color(0xFF5D4037)),
  ),
)
```

### FAB

```dart
// Brass-style FAB
FloatingActionButton(
  backgroundColor: Color(0xFF5D4037),
  foregroundColor: Color(0xFFFAF3E0),
  elevation: 2,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  ),
  child: Icon(Icons.add),
)
```

### Chips/Filter

```dart
FilterChip(
  selected: isSelected,
  label: Text('Filter'),
  backgroundColor: Color(0xFFEDE0C8),
  selectedColor: Color(0xFFD4AF37).withOpacity(0.3),
  checkmarkColor: Color(0xFF5D4037),
  side: BorderSide(
    color: isSelected ? Color(0xFFB8860B) : Color(0xFF8D7355).withOpacity(0.5),
  ),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  ),
)
```

### Checkbox

```dart
Checkbox(
  value: isChecked,
  activeColor: Color(0xFF5D4037),
  checkColor: Color(0xFFFAF3E0),
  side: BorderSide(color: Color(0xFF5D4037), width: 1.5),
)
```

### Navigation Bar

```dart
NavigationBar(
  backgroundColor: Color(0xFFEDE0C8),
  indicatorColor: Color(0xFFD4AF37).withOpacity(0.3),
  labelTextStyle: MaterialStateProperty.resolveWith((states) {
    if (states.contains(MaterialState.selected)) {
      return TextStyle(color: Color(0xFF5D4037), fontWeight: FontWeight.w600);
    }
    return TextStyle(color: Color(0xFF8D7355));
  }),
)
```

## Layout & Spacing

### Spacing System

```dart
// 8px-based spacing with generous padding for classic feel
const spacing = (
  xs: 4.0,
  sm: 8.0,
  md: 16.0,
  lg: 24.0,
  xl: 32.0,
  xxl: 48.0,
);

// Content area - slightly more generous for elegance
Padding(
  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
  child: ...
)

// Card padding - comfortable reading space
Card(
  child: Padding(
    padding: EdgeInsets.all(16),
    child: ...
  ),
)
```

### Corner Radius

```dart
// More subtle radius for classic feel
const radius = (
  sm: 4.0,   // Small elements
  md: 8.0,   // Cards, inputs
  lg: 12.0,  // Buttons
  xl: 16.0,  // FAB
  full: 9999.0, // Circular
);
```

## Motion & Animation

### Timing Guidelines
- Keep animations subtle and refined
- **Short operations**: 100-150ms
- **Screen transitions**: 250-350ms
- **Curve**: `easeOutCubic` for smooth, elegant motion

## Checklist

When implementing antique-themed UI:

- [ ] Using serif fonts (Playfair Display, Merriweather, etc.)
- [ ] Color palette uses parchment/cream backgrounds
- [ ] Accent colors are brass/gold tones
- [ ] Text is dark brown/sepia (not pure black)
- [ ] Corner radii are subtle (8-12px)
- [ ] Borders/outlines used for definition
- [ ] Overall feel is warm and classic
