import 'package:flutter/material.dart';

import 'package:flutter_autonomous_template/core/theme/app_colors.dart';
import 'package:flutter_autonomous_template/core/theme/app_spacing.dart';

/// Discord-style input bar for adding new messages/items
///
/// Features:
/// - Leading action button (e.g., +)
/// - Text input field
/// - Trailing action buttons (e.g., emoji, send)
/// - Bottom safe area padding
class DiscordInputBar extends StatelessWidget {
  const DiscordInputBar({
    super.key,
    required this.controller,
    this.hintText,
    this.onSubmitted,
    this.onLeadingPressed,
    this.leadingIcon = Icons.add,
    this.trailingActions,
    this.focusNode,
    this.enabled = true,
  });

  /// Text editing controller
  final TextEditingController controller;

  /// Placeholder text
  final String? hintText;

  /// Called when the user submits (presses enter/send)
  final ValueChanged<String>? onSubmitted;

  /// Called when the leading button is pressed
  final VoidCallback? onLeadingPressed;

  /// Icon for the leading button
  final IconData leadingIcon;

  /// Optional trailing action buttons
  final List<InputBarAction>? trailingActions;

  /// Focus node for the text field
  final FocusNode? focusNode;

  /// Whether the input is enabled
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
        isDark ? DiscordColors.surfaceDark : DiscordColors.surfaceLight;
    final inputBgColor = isDark
        ? DiscordColors.backgroundDark
        : DiscordColors.backgroundLight.withValues(alpha: 0.5);
    final iconColor =
        isDark ? DiscordColors.textMutedDark : DiscordColors.textMutedLight;
    final textColor =
        isDark ? DiscordColors.textPrimaryDark : DiscordColors.textPrimaryLight;
    final hintColor =
        isDark ? DiscordColors.textMutedDark : DiscordColors.textMutedLight;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            children: [
              // Leading action button
              _buildIconButton(
                icon: leadingIcon,
                color: iconColor,
                onPressed: enabled ? onLeadingPressed : null,
              ),
              const HGap.sm(),
              // Text input field
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: inputBgColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: controller,
                    focusNode: focusNode,
                    enabled: enabled,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 15,
                    ),
                    decoration: InputDecoration(
                      hintText: hintText ?? 'Message...',
                      hintStyle: TextStyle(
                        color: hintColor,
                        fontSize: 15,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                    ),
                    textInputAction: TextInputAction.send,
                    onSubmitted: enabled ? onSubmitted : null,
                  ),
                ),
              ),
              // Trailing actions
              if (trailingActions != null && trailingActions!.isNotEmpty)
                ...trailingActions!.map(
                  (action) => Padding(
                    padding: const EdgeInsets.only(left: AppSpacing.xs),
                    child: _buildIconButton(
                      icon: action.icon,
                      color: action.color ?? iconColor,
                      onPressed: enabled ? action.onPressed : null,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required Color color,
    VoidCallback? onPressed,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Icon(
            icon,
            color: onPressed != null ? color : color.withValues(alpha: 0.5),
            size: 24,
          ),
        ),
      ),
    );
  }
}

/// Represents an action button in the input bar
class InputBarAction {
  const InputBarAction({
    required this.icon,
    this.onPressed,
    this.color,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final Color? color;
  final String? tooltip;
}

/// A variant of DiscordInputBar that includes a send button
class DiscordInputBarWithSend extends StatefulWidget {
  const DiscordInputBarWithSend({
    super.key,
    this.hintText,
    required this.onSend,
    this.onLeadingPressed,
    this.leadingIcon = Icons.add,
  });

  final String? hintText;
  final ValueChanged<String> onSend;
  final VoidCallback? onLeadingPressed;
  final IconData leadingIcon;

  @override
  State<DiscordInputBarWithSend> createState() =>
      _DiscordInputBarWithSendState();
}

class _DiscordInputBarWithSendState extends State<DiscordInputBarWithSend> {
  late final TextEditingController _controller;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final hasText = _controller.text.trim().isNotEmpty;
    if (hasText != _hasText) {
      setState(() {
        _hasText = hasText;
      });
    }
  }

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      widget.onSend(text);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DiscordInputBar(
      controller: _controller,
      hintText: widget.hintText,
      onSubmitted: (_) => _handleSend(),
      onLeadingPressed: widget.onLeadingPressed,
      leadingIcon: widget.leadingIcon,
      trailingActions: [
        InputBarAction(
          icon: _hasText ? Icons.send : Icons.mic,
          color: _hasText ? DiscordColors.blurple : null,
          onPressed: _hasText ? _handleSend : null,
        ),
      ],
    );
  }
}
