---
name: discord-theming
description: "Discord UI theming skill for Flutter apps. Use when applying Discord-style design with Blurple colors, pill buttons, and modern UI patterns."
---

# Discord Theming Skill

## Purpose

Apply Discord's design system to Flutter apps. This skill provides guidelines for colors, typography, border radius, and component patterns that match Discord's mobile UI.

## Discord Design System

### Color Palette

| Color | Hex | Usage |
|-------|-----|-------|
| Blurple | #5865F2 | Primary actions, buttons, links |
| Green | #3BA55C | Success, online status |
| Yellow | #FEE75C | Warnings, idle status |
| Fuchsia | #EB459E | Boosts, special features |
| Red | #ED4245 | Errors, destructive actions |

#### Light Mode
| Element | Hex |
|---------|-----|
| Background | #FFFFFF |
| Surface | #F2F3F5 |
| Text Primary | #060607 |
| Text Secondary | #4E5058 |

#### Dark Mode
| Element | Hex |
|---------|-----|
| Background | #313338 |
| Surface | #2B2D31 |
| Text Primary | #FFFFFF |
| Text Secondary | #B5BAC1 |

---

## Typography

### Font Family
- Primary: gg sans (alternative: Inter, ABCGinto Nord)
- Characteristics: Clean, rounded, modern sans-serif

### Font Weights
- Regular: 400 (body text)
- Medium: 500 (UI labels)
- Semibold: 600 (headings)
- Bold: 700 (titles, emphasis)

### Text Styles
| Style | Size | Weight |
|-------|------|--------|
| Title | 24px | Bold |
| Headline | 20px | Semibold |
| Body | 16px | Regular |
| Caption | 14px | Regular |
| Small | 12px | Medium |

---

## Border Radius

| Component | Radius |
|-----------|--------|
| Pill Button | 24px (full) |
| Input Field | 8px |
| Card | 12px |
| Avatar | 50% (circle) |
| Bottom Sheet | 16px (top only) |
| Chip/Badge | 4px |

---

## Component Patterns

### 1. Pill Button (Primary Action)

```dart
DiscordPillButton(
  label: 'Sign In',
  onPressed: () {},
  variant: DiscordButtonVariant.filled, // or .outlined
  isLoading: false,
)
```

**Characteristics:**
- Full rounded corners (pill shape)
- Blurple fill for primary actions
- White/transparent for secondary
- Loading state with spinner

### 2. Text Field

```dart
DiscordTextField(
  label: 'Email',
  hint: 'Enter your email',
  controller: _controller,
)
```

**Characteristics:**
- Gray background (#F2F3F5 light / #2B2D31 dark)
- 8px border radius
- No visible border (except focus)
- Blurple focus indicator

### 3. Segmented Control

```dart
DiscordSegmentedControl(
  segments: ['Phone', 'Email'],
  selectedIndex: 0,
  onChanged: (index) {},
)
```

**Characteristics:**
- Pill-shaped container
- Selected: white/dark background
- Unselected: transparent
- Smooth transition animation

### 4. List Tile

```dart
DiscordListTile(
  leading: CircleAvatar(...),
  title: 'Username',
  subtitle: 'Status message',
  trailing: Icon(Icons.chevron_right),
  onTap: () {},
)
```

**Characteristics:**
- Avatar on left (circle)
- Title + subtitle layout
- Optional trailing widget
- Tap ripple effect

### 5. Bottom Sheet

```dart
DiscordBottomSheet.show(
  context: context,
  title: 'Confirm Action',
  description: 'Are you sure?',
  illustration: SvgPicture.asset('...'),
  primaryAction: DiscordPillButton(...),
  secondaryAction: DiscordPillButton(...),
)
```

**Characteristics:**
- Rounded top corners (16px)
- Optional illustration
- Title + description
- Primary/secondary action buttons

---

## Implementation Files

### Theme Files
```
lib/core/theme/
├── app_colors.dart      # DiscordColors class
├── app_radius.dart      # Discord radius values
└── app_theme.dart       # Discord theme integration
```

### Components
```
lib/core/components/discord/
├── discord_pill_button.dart
├── discord_text_field.dart
├── discord_segmented_control.dart
├── discord_list_tile.dart
└── discord_bottom_sheet.dart
```

---

## Usage Example

### Applying Discord Theme

```dart
// In app_colors.dart
class DiscordColors {
  static const Color blurple = Color(0xFF5865F2);
  static const Color green = Color(0xFF3BA55C);
  // ... other colors
}

// In screens
import 'package:flutter_autonomous_template/core/components/discord/discord_pill_button.dart';

DiscordPillButton(
  label: l10n.signIn,
  onPressed: _handleSignIn,
  isLoading: isLoading,
)
```

---

## Best Practices

1. **Use semantic colors** - Access colors through DiscordColors class
2. **Consistent radius** - Use AppRadius.pill for buttons, AppRadius.discordInput for fields
3. **Maintain contrast** - Ensure text is readable on all backgrounds
4. **Support both themes** - Test Light and Dark modes
5. **Animation timing** - Use 200ms for transitions (Discord standard)

---

## Reference

- Discord Brand Guidelines
- Reference images: `/Users/kotahayashi/Workspace/UI Pocket_Discord_2025-10/`
