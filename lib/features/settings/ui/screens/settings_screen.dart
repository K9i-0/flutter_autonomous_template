import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_autonomous_template/core/config/build_config.dart';
import 'package:flutter_autonomous_template/core/debug/debug_settings_provider.dart';
import 'package:flutter_autonomous_template/core/l10n/app_localizations.dart';
import 'package:flutter_autonomous_template/core/router/app_router.gr.dart';
import 'package:flutter_autonomous_template/core/theme/app_radius.dart';
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
      appBar: AppBar(title: Text(l10n.settings)),
      body: ListView(
        padding: AppSpacing.screenPadding,
        children: [
          _buildSectionCard(
            context,
            title: l10n.theme,
            icon: Icons.palette,
            child: _buildThemeSection(context, ref, settings, l10n),
          ),
          const VGap.md(),
          _buildSectionCard(
            context,
            title: l10n.language,
            icon: Icons.language,
            child: _buildLanguageSection(context, ref, settings, l10n),
          ),
          const VGap.md(),
          _buildSectionCard(
            context,
            title: 'Information',
            icon: Icons.info_outline,
            child: _buildAboutSection(context, l10n),
          ),
          const VGap.md(),
          _buildSectionCard(
            context,
            title: l10n.account,
            icon: Icons.person,
            child: _buildAccountSection(context, ref, l10n),
          ),
          if (kDebugMode) ...[
            const VGap.md(),
            _buildSectionCard(
              context,
              title: l10n.debugInfo,
              icon: Icons.bug_report,
              isDebug: true,
              child: _buildDebugSection(context, ref, l10n),
            ),
          ],
          const VGap.lg(),
        ],
      ),
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Widget child,
    bool isDebug = false,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final accentColor = isDebug ? colorScheme.error : colorScheme.primary;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: AppRadius.card,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with accent line
          Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: accentColor,
                  width: 4,
                ),
              ),
            ),
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.1),
                    borderRadius: AppRadius.smAll,
                  ),
                  child: Icon(
                    icon,
                    color: accentColor,
                    size: 20,
                  ),
                ),
                const HGap.md(),
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDebug ? accentColor : null,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Content
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _buildThemeSection(
    BuildContext context,
    WidgetRef ref,
    AppSettings settings,
    AppLocalizations l10n,
  ) {
    return Column(
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
    AppLocalizations l10n,
  ) {
    return Column(
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

  Widget _buildAboutSection(BuildContext context, AppLocalizations l10n) {
    return ListTile(
      leading: const Icon(Icons.info_outline),
      title: const Text('About'),
      trailing: const Icon(Icons.chevron_right),
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

  Widget _buildAccountSection(BuildContext context, WidgetRef ref, AppLocalizations l10n) {
    final theme = Theme.of(context);
    final currentUser = ref.watch(currentUserProvider);
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState.isLoading;

    return Column(
      children: [
        if (currentUser != null) ...[
          ListTile(
            leading: CircleAvatar(
              backgroundColor: theme.colorScheme.secondary.withOpacity(0.2),
              child: Text(
                currentUser.name.isNotEmpty
                    ? currentUser.name[0].toUpperCase()
                    : '?',
                style: TextStyle(
                  color: theme.colorScheme.onSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(currentUser.name),
            subtitle: Text(currentUser.email),
          ),
        ],
        ListTile(
          leading: Icon(Icons.logout, color: theme.colorScheme.error),
          title: Text(
            l10n.signOut,
            style: TextStyle(color: theme.colorScheme.error),
          ),
          enabled: !isLoading,
          onTap: () async {
            final confirmed = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(l10n.signOut),
                content: Text(l10n.signOutConfirm),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(l10n.cancel),
                  ),
                  FilledButton(
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
        ),
      ],
    );
  }

  Widget _buildDebugSection(BuildContext context, WidgetRef ref, AppLocalizations l10n) {
    final theme = Theme.of(context);
    final config = BuildConfig.fromEnvironment();
    final debugSettings = ref.watch(debugSettingsProvider);
    final debugNotifier = ref.read(debugSettingsProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDebugItem('Flavor', config.flavor.name.toUpperCase()),
              _buildDebugItem('App Name', config.appName),
              _buildDebugItem('Base URL', config.baseUrl),
            ],
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Text(
            l10n.repositoryDebug,
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.error,
            ),
          ),
        ),
        SwitchListTile(
          title: Text(l10n.useDebugRepository),
          subtitle: Text(l10n.useDebugRepositoryDesc),
          value: debugSettings.useDebugRepository,
          onChanged: (_) => debugNotifier.toggleUseDebugRepository(),
        ),
        Center(
          child: TextButton.icon(
            onPressed: debugNotifier.resetToDefaults,
            icon: const Icon(Icons.refresh),
            label: Text(l10n.resetToDefaults),
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
