---
name: flutter-ui-design
description: McDonald's-inspired UI design guidelines for Flutter apps. Bold colors, friendly shapes, and promotional elements.
---

# Flutter UI Design Guidelines - McDonald's Style

## Purpose

This skill provides guidelines to create Flutter apps with McDonald's-inspired UI design. Features bold red and yellow colors, friendly rounded shapes, and promotional card-based layouts.

## Brand Colors

### McDonald's Color Palette

```dart
// Primary: McDonald's Red
static const Color primaryLight = Color(0xFFDA291C);
static const Color primaryDark = Color(0xFFE74C3C);

// Secondary: McDonald's Yellow/Gold
static const Color secondaryLight = Color(0xFFFFC72C);
static const Color secondaryDark = Color(0xFFF1C40F);

// Supporting Colors
static const Color errorLight = Color(0xFFDC3545);
static const Color successLight = Color(0xFF28A745);
static const Color warningLight = Color(0xFFFFC72C);
```

### Usage Guidelines
- **Primary (Red)**: Headers, accent borders, primary buttons, error states
- **Secondary (Yellow)**: CTAs, FABs, highlights, promotional banners
- **Neutral**: White backgrounds, gray surfaces, dark text

## Typography

### Font Pairing

```dart
// Headlines: Poppins (Bold, impactful)
GoogleFonts.poppins(fontWeight: FontWeight.w700)

// Body: Nunito Sans (Friendly, readable)
GoogleFonts.nunitoSans(fontWeight: FontWeight.w400)

// Labels/Badges: Poppins SemiBold
GoogleFonts.poppins(fontWeight: FontWeight.w600)
```

### Size Hierarchy
```dart
headlineLarge: 32sp, weight: 700
headlineMedium: 28sp, weight: 600
titleLarge: 22sp, weight: 700
titleMedium: 16sp, weight: 600
bodyLarge: 16sp, weight: 400
bodyMedium: 14sp, weight: 400
labelMedium: 12sp, weight: 500
```

## Border Radius

McDonald's uses moderate, friendly rounding (not pill-shaped):

```dart
// Component-specific presets
static const BorderRadius button = 8px;      // Buttons
static const BorderRadius input = 8px;       // Input fields
static const BorderRadius card = 12px;       // Cards
static const BorderRadius badge = 4px;       // Badges/Tags
static const BorderRadius fab = circular;    // FAB is circular
static const BorderRadius banner = 8px;      // Promotional banners
```

## Component Styles

### Buttons

```dart
// Primary Button (Red)
FilledButton(
  style: FilledButton.styleFrom(
    backgroundColor: colorScheme.primary,  // Red
    foregroundColor: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
)

// Secondary Button (Yellow)
OutlinedButton(
  style: OutlinedButton.styleFrom(
    backgroundColor: colorScheme.secondary,  // Yellow
    foregroundColor: Color(0xFF292929),      // Dark text
    side: BorderSide.none,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
)
```

### Cards with Left Border Accent

```dart
Container(
  decoration: BoxDecoration(
    color: colorScheme.surface,
    borderRadius: BorderRadius.circular(12),
    border: Border(
      left: BorderSide(
        color: accentColor,  // Category or priority color
        width: 4,
      ),
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

### Promotional Banner

```dart
Container(
  padding: EdgeInsets.all(16),
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [
        colorScheme.secondary,
        colorScheme.secondary.withOpacity(0.8),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: colorScheme.secondary.withOpacity(0.3),
        blurRadius: 8,
        offset: Offset(0, 4),
      ),
    ],
  ),
  child: Row(
    children: [
      Icon(Icons.local_offer, color: Colors.black87),
      SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Special Offer!', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Description text here'),
          ],
        ),
      ),
      Icon(Icons.arrow_forward_ios),
    ],
  ),
)
```

### Priority/Status Badges

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
      Text(
        badgeText,
        style: TextStyle(
          color: badgeColor,
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
      ),
    ],
  ),
)
```

### FAB (Circular, Yellow)

```dart
FloatingActionButton(
  elevation: 4,
  backgroundColor: colorScheme.secondary,  // Yellow
  foregroundColor: colorScheme.onSecondary, // Dark icon
  shape: CircleBorder(),
  child: Icon(Icons.add),
)
```

### Section Cards (Settings)

```dart
Container(
  decoration: BoxDecoration(
    color: colorScheme.surface,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [BoxShadow(...)],
  ),
  child: Column(
    children: [
      // Header with icon and accent border
      Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(color: accentColor, width: 4),
          ),
        ),
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: accentColor),
            ),
            SizedBox(width: 12),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      Divider(height: 1),
      // Content
      Padding(padding: EdgeInsets.all(8), child: content),
    ],
  ),
)
```

## Layout Patterns

### Spacing System (8px base)

```dart
const spacing = (
  xs: 4.0,
  sm: 8.0,
  md: 16.0,
  lg: 24.0,
  xl: 32.0,
);
```

### Screen Structure

```
├── AppBar (white/surface background)
├── Promotional Banner (yellow gradient)
├── Content Cards (white with shadow)
│   ├── Left border accent (category color)
│   ├── Title + Description
│   └── Status badges (priority/completion)
└── FAB (circular, yellow)
```

## Design Checklist

When implementing McDonald's-style UI:

- [ ] Using McDonald's Red (#DA291C) as primary
- [ ] Using McDonald's Yellow (#FFC72C) for CTAs and FAB
- [ ] Cards have left border accent for categorization
- [ ] Badges for status/priority indicators
- [ ] Rounded corners are 8-12px (not pill-shaped)
- [ ] FAB is circular and yellow
- [ ] Promotional banners use yellow gradient
- [ ] Section cards have icon headers
- [ ] Typography: Poppins (headlines) + Nunito Sans (body)
- [ ] Shadows are subtle but present (elevation effect)
