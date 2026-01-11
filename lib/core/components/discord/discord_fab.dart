import 'package:flutter/material.dart';

import 'package:flutter_autonomous_template/core/theme/app_colors.dart';

/// Discord-style floating action button
///
/// A circular FAB with Discord's Blurple color.
class DiscordFAB extends StatelessWidget {
  const DiscordFAB({
    super.key,
    required this.onPressed,
    this.icon = Icons.add,
    this.tooltip,
  });

  final VoidCallback? onPressed;
  final IconData icon;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: DiscordColors.blurple,
      foregroundColor: Colors.white,
      elevation: 4,
      tooltip: tooltip,
      child: Icon(icon),
    );
  }
}

/// Discord-style extended floating action button
class DiscordExtendedFAB extends StatelessWidget {
  const DiscordExtendedFAB({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
    this.tooltip,
  });

  final VoidCallback? onPressed;
  final String label;
  final IconData? icon;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      backgroundColor: DiscordColors.blurple,
      foregroundColor: Colors.white,
      elevation: 4,
      tooltip: tooltip,
      icon: icon != null ? Icon(icon) : null,
      label: Text(label),
    );
  }
}
