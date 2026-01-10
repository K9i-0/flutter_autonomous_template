import 'package:flutter/material.dart';

import 'package:flutter_autonomous_template/core/theme/app_spacing.dart';

/// Unified button variants for the application
enum AppButtonVariant {
  /// Solid filled button (primary action)
  filled,

  /// Outlined button (secondary action)
  outlined,

  /// Text-only button (tertiary action)
  text,

  /// Tonal button (medium emphasis)
  tonal,
}

/// Unified button sizes
enum AppButtonSize {
  small,
  medium,
  large,
}

/// Application button component
///
/// A unified button widget that supports multiple variants and sizes.
class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.variant = AppButtonVariant.filled,
    this.size = AppButtonSize.medium,
    this.icon,
    this.iconPosition = IconPosition.leading,
    this.isLoading = false,
    this.isExpanded = false,
  });

  /// Button label text
  final String label;

  /// Callback when button is pressed (null for disabled state)
  final VoidCallback? onPressed;

  /// Button visual variant
  final AppButtonVariant variant;

  /// Button size
  final AppButtonSize size;

  /// Optional icon
  final IconData? icon;

  /// Icon position relative to label
  final IconPosition iconPosition;

  /// Show loading indicator
  final bool isLoading;

  /// Expand to fill available width
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    final effectiveOnPressed = isLoading ? null : onPressed;

    Widget button = switch (variant) {
      AppButtonVariant.filled => _buildFilledButton(context, effectiveOnPressed),
      AppButtonVariant.outlined =>
        _buildOutlinedButton(context, effectiveOnPressed),
      AppButtonVariant.text => _buildTextButton(context, effectiveOnPressed),
      AppButtonVariant.tonal => _buildTonalButton(context, effectiveOnPressed),
    };

    if (isExpanded) {
      button = SizedBox(width: double.infinity, child: button);
    }

    return button;
  }

  Widget _buildFilledButton(BuildContext context, VoidCallback? onPressed) {
    if (icon != null) {
      return FilledButton.icon(
        onPressed: onPressed,
        icon: _buildIconOrLoader(context),
        label: Text(label),
        style: _getButtonStyle(context),
      );
    }
    return FilledButton(
      onPressed: onPressed,
      style: _getButtonStyle(context),
      child: _buildContent(context),
    );
  }

  Widget _buildOutlinedButton(BuildContext context, VoidCallback? onPressed) {
    if (icon != null) {
      return OutlinedButton.icon(
        onPressed: onPressed,
        icon: _buildIconOrLoader(context),
        label: Text(label),
        style: _getButtonStyle(context),
      );
    }
    return OutlinedButton(
      onPressed: onPressed,
      style: _getButtonStyle(context),
      child: _buildContent(context),
    );
  }

  Widget _buildTextButton(BuildContext context, VoidCallback? onPressed) {
    if (icon != null) {
      return TextButton.icon(
        onPressed: onPressed,
        icon: _buildIconOrLoader(context),
        label: Text(label),
        style: _getButtonStyle(context),
      );
    }
    return TextButton(
      onPressed: onPressed,
      style: _getButtonStyle(context),
      child: _buildContent(context),
    );
  }

  Widget _buildTonalButton(BuildContext context, VoidCallback? onPressed) {
    if (icon != null) {
      return FilledButton.tonalIcon(
        onPressed: onPressed,
        icon: _buildIconOrLoader(context),
        label: Text(label),
        style: _getButtonStyle(context),
      );
    }
    return FilledButton.tonal(
      onPressed: onPressed,
      style: _getButtonStyle(context),
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        height: _getLoaderSize(),
        width: _getLoaderSize(),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation(
            _getLoaderColor(context),
          ),
        ),
      );
    }
    return Text(label);
  }

  Widget _buildIconOrLoader(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        height: _getLoaderSize(),
        width: _getLoaderSize(),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation(
            _getLoaderColor(context),
          ),
        ),
      );
    }
    return Icon(icon, size: _getIconSize());
  }

  ButtonStyle? _getButtonStyle(BuildContext context) {
    return switch (size) {
      AppButtonSize.small => ButtonStyle(
        padding: WidgetStateProperty.all(AppSpacing.buttonPaddingSmall),
        textStyle: WidgetStateProperty.all(
          Theme.of(context).textTheme.labelMedium,
        ),
      ),
      AppButtonSize.medium => null, // Use theme default
      AppButtonSize.large => ButtonStyle(
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.lg,
          ),
        ),
        textStyle: WidgetStateProperty.all(
          Theme.of(context).textTheme.titleMedium,
        ),
      ),
    };
  }

  double _getIconSize() {
    return switch (size) {
      AppButtonSize.small => 16,
      AppButtonSize.medium => 20,
      AppButtonSize.large => 24,
    };
  }

  double _getLoaderSize() {
    return switch (size) {
      AppButtonSize.small => 14,
      AppButtonSize.medium => 18,
      AppButtonSize.large => 22,
    };
  }

  Color _getLoaderColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return switch (variant) {
      AppButtonVariant.filled => colorScheme.onPrimary,
      AppButtonVariant.outlined => colorScheme.primary,
      AppButtonVariant.text => colorScheme.primary,
      AppButtonVariant.tonal => colorScheme.onSecondaryContainer,
    };
  }
}

/// Icon position relative to button label
enum IconPosition {
  leading,
  trailing,
}
