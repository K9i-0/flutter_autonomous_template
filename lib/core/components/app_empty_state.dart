import 'package:flutter/material.dart';

import 'package:flutter_autonomous_template/core/components/app_button.dart';
import 'package:flutter_autonomous_template/core/theme/app_spacing.dart';

/// Empty state placeholder
///
/// Displays when there's no content to show (empty lists, no search results, etc.)
class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    required this.title,
    super.key,
    this.description,
    this.icon,
    this.action,
    this.actionLabel,
    this.onAction,
  });

  /// Primary message
  final String title;

  /// Optional secondary description
  final String? description;

  /// Optional icon to display
  final IconData? icon;

  /// Custom action widget (takes precedence over actionLabel/onAction)
  final Widget? action;

  /// Label for the action button
  final String? actionLabel;

  /// Callback when action button is pressed
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: AppSpacing.screenPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 64,
                color: theme.colorScheme.onSurfaceVariant.withValues(
                  alpha: 0.5,
                ),
              ),
              const VGap.lg(),
            ],
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            if (description != null) ...[
              const VGap.sm(),
              Text(
                description!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (action != null) ...[
              const VGap.lg(),
              action!,
            ] else if (actionLabel != null && onAction != null) ...[
              const VGap.lg(),
              AppButton(
                label: actionLabel!,
                onPressed: onAction,
                variant: AppButtonVariant.filled,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Error state placeholder
class AppErrorState extends StatelessWidget {
  const AppErrorState({
    super.key,
    this.title = 'Something went wrong',
    this.description,
    this.error,
    this.retryLabel = 'Try again',
    this.onRetry,
  });

  final String title;
  final String? description;
  final Object? error;
  final String retryLabel;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return AppEmptyState(
      icon: Icons.error_outline,
      title: title,
      description: description ?? error?.toString(),
      action: onRetry != null
          ? AppButton(
              label: retryLabel,
              onPressed: onRetry,
              variant: AppButtonVariant.outlined,
              icon: Icons.refresh,
            )
          : null,
    );
  }
}

/// No results state (for search)
class AppNoResultsState extends StatelessWidget {
  const AppNoResultsState({super.key, this.query, this.onClear});

  final String? query;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    return AppEmptyState(
      icon: Icons.search_off,
      title: 'No results found',
      description: query != null ? 'No results for "$query"' : null,
      actionLabel: onClear != null ? 'Clear search' : null,
      onAction: onClear,
    );
  }
}
