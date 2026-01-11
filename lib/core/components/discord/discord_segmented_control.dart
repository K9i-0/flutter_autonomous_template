import 'package:flutter/material.dart';

import 'package:flutter_autonomous_template/core/theme/app_colors.dart';
import 'package:flutter_autonomous_template/core/theme/app_radius.dart';
import 'package:flutter_autonomous_template/core/theme/app_spacing.dart';

/// Discord-style segmented control
///
/// A tab-like control with pill-shaped container and smooth transitions,
/// following Discord's design language (e.g., Phone/Email switch).
class DiscordSegmentedControl extends StatelessWidget {
  const DiscordSegmentedControl({
    required this.segments,
    required this.selectedIndex,
    required this.onChanged,
    super.key,
  });

  final List<String> segments;
  final int selectedIndex;
  final void Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
        isDark ? DiscordColors.surfaceDark : DiscordColors.surfaceLight;
    final selectedColor =
        isDark ? DiscordColors.backgroundDark : Colors.white;
    final textColor =
        isDark
            ? DiscordColors.textPrimaryDark
            : DiscordColors.textPrimaryLight;
    final unselectedTextColor =
        isDark
            ? DiscordColors.textSecondaryDark
            : DiscordColors.textSecondaryLight;

    return Container(
      height: 44,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: AppRadius.pillAll,
      ),
      child: Row(
        children:
            segments.asMap().entries.map((entry) {
              final index = entry.key;
              final label = entry.value;
              final isSelected = index == selectedIndex;

              return Expanded(
                child: GestureDetector(
                  onTap: () => onChanged(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: isSelected ? selectedColor : Colors.transparent,
                      borderRadius: AppRadius.pillAll,
                      boxShadow:
                          isSelected
                              ? [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                              : null,
                    ),
                    child: Center(
                      child: Text(
                        label,
                        style: TextStyle(
                          color: isSelected ? textColor : unselectedTextColor,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}

/// Discord-style tab bar with underline indicator
///
/// A horizontal tab bar following Discord's design language.
class DiscordTabBar extends StatelessWidget {
  const DiscordTabBar({
    required this.tabs,
    required this.selectedIndex,
    required this.onChanged,
    super.key,
  });

  final List<String> tabs;
  final int selectedIndex;
  final void Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark
            ? DiscordColors.textPrimaryDark
            : DiscordColors.textPrimaryLight;
    final unselectedTextColor =
        isDark
            ? DiscordColors.textSecondaryDark
            : DiscordColors.textSecondaryLight;

    return SizedBox(
      height: 44,
      child: Row(
        children:
            tabs.asMap().entries.map((entry) {
              final index = entry.key;
              final label = entry.value;
              final isSelected = index == selectedIndex;

              return Expanded(
                child: GestureDetector(
                  onTap: () => onChanged(index),
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        label,
                        style: TextStyle(
                          color: isSelected ? textColor : unselectedTextColor,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      const VGap.xs(),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: 2,
                        width: isSelected ? 40 : 0,
                        decoration: BoxDecoration(
                          color: DiscordColors.blurple,
                          borderRadius: AppRadius.fullAll,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
