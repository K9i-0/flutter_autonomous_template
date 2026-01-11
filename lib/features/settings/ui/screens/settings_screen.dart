import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_autonomous_template/core/config/build_config.dart';
import 'package:flutter_autonomous_template/core/debug/debug_settings_provider.dart';
import 'package:flutter_autonomous_template/core/l10n/app_localizations.dart';
import 'package:flutter_autonomous_template/core/router/app_router.gr.dart';
import 'package:flutter_autonomous_template/core/theme/app_spacing.dart';
import 'package:flutter_autonomous_template/features/auth/providers/auth_provider.dart';
import 'package:flutter_autonomous_template/features/settings/data/models/app_settings.dart';
import 'package:flutter_autonomous_template/features/settings/providers/settings_provider.dart';

@RoutePage()
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: _buildHeader(context, l10n),
            ),
            // Account Card
            SliverToBoxAdapter(
              child: _buildAccountCard(context, ref, l10n),
            ),
            // Settings sections
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildSettingsCard(
                      context,
                      title: l10n.theme,
                      icon: Icons.palette_outlined,
                      children: [
                        _buildThemeOption(
                          context,
                          ref,
                          title: l10n.themeSystem,
                          icon: Icons.brightness_auto,
                          value: ThemeModeValue.system,
                          currentValue: settings.themeMode,
                        ),
                        _buildThemeOption(
                          context,
                          ref,
                          title: l10n.themeLight,
                          icon: Icons.light_mode,
                          value: ThemeModeValue.light,
                          currentValue: settings.themeMode,
                        ),
                        _buildThemeOption(
                          context,
                          ref,
                          title: l10n.themeDark,
                          icon: Icons.dark_mode,
                          value: ThemeModeValue.dark,
                          currentValue: settings.themeMode,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildSettingsCard(
                      context,
                      title: l10n.language,
                      icon: Icons.language,
                      children: [
                        _buildLanguageOption(
                          context,
                          ref,
                          title: l10n.languageEnglish,
                          locale: 'en',
                          currentLocale: settings.locale,
                        ),
                        _buildLanguageOption(
                          context,
                          ref,
                          title: l10n.languageJapanese,
                          locale: 'ja',
                          currentLocale: settings.locale,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildSettingsCard(
                      context,
                      title: 'General',
                      icon: Icons.settings_outlined,
                      children: [
                        _buildAboutTile(context, l10n),
                      ],
                    ),
                    if (kDebugMode) ...[
                      const SizedBox(height: 16),
                      _buildDebugCard(context, ref, l10n),
                    ],
                    const SizedBox(height: 32),
                    _buildSignOutButton(context, ref, l10n),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      child: Text(
        l10n.settings,
        style: theme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildAccountCard(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) {
    final theme = Theme.of(context);
    final currentUser = ref.watch(currentUserProvider);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primary.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                currentUser?.name.isNotEmpty == true
                    ? currentUser!.name[0].toUpperCase()
                    : '?',
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // User info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentUser?.name ?? 'Guest',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  currentUser?.email ?? '',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onPrimary.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
          // Edit icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.edit_outlined,
              color: theme.colorScheme.onPrimary,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                Icon(icon, size: 20, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          // Children
          ...children,
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    WidgetRef ref, {
    required String title,
    required IconData icon,
    required ThemeModeValue value,
    required ThemeModeValue currentValue,
  }) {
    final theme = Theme.of(context);
    final isSelected = value == currentValue;

    return ListTile(
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary.withValues(alpha: 0.1)
              : theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 20,
          color: isSelected
              ? theme.colorScheme.primary
              : theme.colorScheme.onSurfaceVariant,
        ),
      ),
      title: Text(
        title,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: isSelected ? theme.colorScheme.primary : null,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
      trailing: isSelected
          ? Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check,
                size: 16,
                color: theme.colorScheme.onPrimary,
              ),
            )
          : null,
      onTap: () {
        ref.read(settingsProvider.notifier).setThemeMode(value);
      },
    );
  }

  Widget _buildLanguageOption(
    BuildContext context,
    WidgetRef ref, {
    required String title,
    required String locale,
    required String currentLocale,
  }) {
    final theme = Theme.of(context);
    final isSelected = locale == currentLocale;

    return ListTile(
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary.withValues(alpha: 0.1)
              : theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            locale.toUpperCase(),
            style: theme.textTheme.labelMedium?.copyWith(
              color: isSelected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      title: Text(
        title,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: isSelected ? theme.colorScheme.primary : null,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
      trailing: isSelected
          ? Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check,
                size: 16,
                color: theme.colorScheme.onPrimary,
              ),
            )
          : null,
      onTap: () {
        ref.read(settingsProvider.notifier).setLocale(locale);
      },
    );
  }

  Widget _buildAboutTile(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          Icons.info_outline,
          size: 20,
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
      title: Text('About', style: theme.textTheme.bodyLarge),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: theme.colorScheme.outline,
      ),
      onTap: () {
        showAboutDialog(
          context: context,
          applicationName: 'TODO App',
          applicationVersion: '1.0.0',
          applicationLegalese: '© 2024',
        );
      },
    );
  }

  Widget _buildDebugCard(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) {
    final theme = Theme.of(context);
    final config = BuildConfig.fromEnvironment();
    final debugSettings = ref.watch(debugSettingsProvider);
    final debugNotifier = ref.read(debugSettingsProvider.notifier);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.error.withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                Icon(Icons.bug_report, size: 20, color: theme.colorScheme.error),
                const SizedBox(width: 8),
                Text(
                  l10n.debugInfo,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.error,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _buildDebugItem('Flavor', config.flavor.name.toUpperCase()),
                _buildDebugItem('App Name', config.appName),
              ],
            ),
          ),
          const Divider(),
          SwitchListTile(
            title: Text(l10n.useDebugRepository),
            subtitle: Text(l10n.useDebugRepositoryDesc),
            value: debugSettings.useDebugRepository,
            onChanged: (_) => debugNotifier.toggleUseDebugRepository(),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildDebugItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(fontFamily: 'monospace')),
          ),
        ],
      ),
    );
  }

  Widget _buildSignOutButton(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) {
    final theme = Theme.of(context);
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState.isLoading;

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton.icon(
        onPressed: isLoading
            ? null
            : () async {
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    title: Text(l10n.signOut),
                    content: Text(l10n.signOutConfirm),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text(l10n.cancel),
                      ),
                      FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: theme.colorScheme.error,
                        ),
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text(l10n.signOut),
                      ),
                    ],
                  ),
                );

                if (confirmed == true) {
                  await ref.read(authNotifierProvider.notifier).signOut();
                  if (context.mounted) {
                    context.router.replaceAll([const LoginRoute()]);
                  }
                }
              },
        style: OutlinedButton.styleFrom(
          foregroundColor: theme.colorScheme.error,
          side: BorderSide(color: theme.colorScheme.error),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: const Icon(Icons.logout),
        label: Text(
          l10n.signOut,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
