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

    return Scaffold(
      appBar: AppBar(title: Text(l10n?.settings ?? 'Settings')),
      body: ListView(
        padding: AppSpacing.screenPadding,
        children: [
          _buildThemeSection(context, ref, settings, l10n),
          const VGap.md(),
          _buildLanguageSection(context, ref, settings, l10n),
          const VGap.md(),
          const Divider(),
          const VGap.md(),
          _buildAboutSection(context, l10n),
          const VGap.md(),
          const Divider(),
          const VGap.md(),
          _buildAccountSection(context, ref),
          if (kDebugMode) ...[
            const VGap.lg(),
            const Divider(),
            const VGap.md(),
            _buildDebugSection(context, ref),
          ],
        ],
      ),
    );
  }

  Widget _buildThemeSection(
    BuildContext context,
    WidgetRef ref,
    AppSettings settings,
    AppLocalizations? l10n,
  ) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n?.theme ?? 'Theme', style: theme.textTheme.titleMedium),
        const VGap.sm(),
        _buildThemeOption(
          context,
          ref,
          title: l10n?.themeSystem ?? 'System',
          icon: Icons.brightness_auto,
          value: ThemeModeValue.system,
          currentValue: settings.themeMode,
        ),
        _buildThemeOption(
          context,
          ref,
          title: l10n?.themeLight ?? 'Light',
          icon: Icons.light_mode,
          value: ThemeModeValue.light,
          currentValue: settings.themeMode,
        ),
        _buildThemeOption(
          context,
          ref,
          title: l10n?.themeDark ?? 'Dark',
          icon: Icons.dark_mode,
          value: ThemeModeValue.dark,
          currentValue: settings.themeMode,
        ),
      ],
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
      leading: Icon(icon, color: isSelected ? theme.colorScheme.primary : null),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? theme.colorScheme.primary : null,
          fontWeight: isSelected ? FontWeight.w600 : null,
        ),
      ),
      trailing: isSelected
          ? Icon(Icons.check, color: theme.colorScheme.primary)
          : null,
      onTap: () {
        ref.read(settingsProvider.notifier).setThemeMode(value);
      },
    );
  }

  Widget _buildLanguageSection(
    BuildContext context,
    WidgetRef ref,
    AppSettings settings,
    AppLocalizations? l10n,
  ) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n?.language ?? 'Language', style: theme.textTheme.titleMedium),
        const VGap.sm(),
        _buildLanguageOption(
          context,
          ref,
          title: l10n?.languageEnglish ?? 'English',
          locale: 'en',
          currentLocale: settings.locale,
        ),
        _buildLanguageOption(
          context,
          ref,
          title: l10n?.languageJapanese ?? '日本語',
          locale: 'ja',
          currentLocale: settings.locale,
        ),
      ],
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
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? theme.colorScheme.primary : null,
          fontWeight: isSelected ? FontWeight.w600 : null,
        ),
      ),
      trailing: isSelected
          ? Icon(Icons.check, color: theme.colorScheme.primary)
          : null,
      onTap: () {
        ref.read(settingsProvider.notifier).setLocale(locale);
      },
    );
  }

  Widget _buildAboutSection(BuildContext context, AppLocalizations? l10n) {
    return ListTile(
      leading: const Icon(Icons.info_outline),
      title: const Text('About'),
      onTap: () {
        showAboutDialog(
          context: context,
          applicationName: 'Flutter Autonomous Template',
          applicationVersion: '1.0.0',
          applicationLegalese: '© 2024',
        );
      },
    );
  }

  Widget _buildAccountSection(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final currentUser = ref.watch(currentUserProvider);
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState.isLoading;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Account', style: theme.textTheme.titleMedium),
        const VGap.sm(),
        if (currentUser != null) ...[
          ListTile(
            leading: CircleAvatar(
              backgroundColor: theme.colorScheme.primaryContainer,
              child: Text(
                currentUser.name.isNotEmpty
                    ? currentUser.name[0].toUpperCase()
                    : '?',
                style: TextStyle(color: theme.colorScheme.onPrimaryContainer),
              ),
            ),
            title: Text(currentUser.name),
            subtitle: Text(currentUser.email),
          ),
        ],
        ListTile(
          leading: Icon(Icons.logout, color: theme.colorScheme.error),
          title: Text(
            'Sign Out',
            style: TextStyle(color: theme.colorScheme.error),
          ),
          enabled: !isLoading,
          onTap: () async {
            final confirmed = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Sign Out'),
                content: const Text('Are you sure you want to sign out?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('Cancel'),
                  ),
                  FilledButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Sign Out'),
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
        ),
      ],
    );
  }

  Widget _buildDebugSection(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final config = BuildConfig.fromEnvironment();
    final debugSettings = ref.watch(debugSettingsProvider);
    final debugNotifier = ref.read(debugSettingsProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.bug_report, color: theme.colorScheme.error),
            const HGap.sm(),
            Text(
              'Debug Info',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
          ],
        ),
        const VGap.sm(),
        _buildDebugItem('Flavor', config.flavor.name.toUpperCase()),
        _buildDebugItem('App Name', config.appName),
        _buildDebugItem('Base URL', config.baseUrl),
        const VGap.md(),
        const Divider(),
        const VGap.sm(),
        Text(
          'Repository Debug',
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.error,
          ),
        ),
        SwitchListTile(
          title: const Text('Use Debug Repository'),
          subtitle: const Text('Show dummy data for screenshots'),
          value: debugSettings.useDebugRepository,
          onChanged: (_) => debugNotifier.toggleUseDebugRepository(),
        ),
        const VGap.sm(),
        Center(
          child: TextButton.icon(
            onPressed: debugNotifier.resetToDefaults,
            icon: const Icon(Icons.refresh),
            label: const Text('Reset to Defaults'),
          ),
        ),
      ],
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
}
