import 'package:flutter/material.dart';

import 'package:flutter_autonomous_template/core/theme/app_colors.dart';

/// Discord-style bottom navigation bar
///
/// A navigation bar with Discord's visual style:
/// - Blurple accent for selected items
/// - Muted colors for unselected items
/// - Clean, minimal design
class DiscordBottomNavBar extends StatelessWidget {
  const DiscordBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final List<DiscordNavDestination> destinations;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
        isDark ? DiscordColors.surfaceDark : DiscordColors.backgroundLight;
    final borderColor =
        isDark ? DiscordColors.surfaceHighDark : DiscordColors.surfaceHighLight;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(
          top: BorderSide(color: borderColor, width: 1),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(destinations.length, (index) {
              final destination = destinations[index];
              final isSelected = index == selectedIndex;

              return _DiscordNavItem(
                destination: destination,
                isSelected: isSelected,
                onTap: () => onDestinationSelected(index),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _DiscordNavItem extends StatelessWidget {
  const _DiscordNavItem({
    required this.destination,
    required this.isSelected,
    required this.onTap,
  });

  final DiscordNavDestination destination;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final selectedColor = DiscordColors.blurple;
    final unselectedColor =
        isDark ? DiscordColors.textMutedDark : DiscordColors.textMutedLight;

    final icon = isSelected ? destination.selectedIcon : destination.icon;
    final color = isSelected ? selectedColor : unselectedColor;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconTheme(
              data: IconThemeData(color: color, size: 24),
              child: icon,
            ),
            const SizedBox(height: 4),
            Text(
              destination.label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A destination for [DiscordBottomNavBar]
class DiscordNavDestination {
  const DiscordNavDestination({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });

  final Widget icon;
  final Widget selectedIcon;
  final String label;
}
