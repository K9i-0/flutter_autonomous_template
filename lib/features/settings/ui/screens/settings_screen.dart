import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_autonomous_template/core/components/discord/discord_components.dart';
import 'package:flutter_autonomous_template/core/config/build_config.dart';
import 'package:flutter_autonomous_template/core/debug/debug_settings_provider.dart';
import 'package:flutter_autonomous_template/core/dev_tools/discord_component_gallery.dart';
import 'package:flutter_autonomous_template/core/l10n/app_localizations.dart';
import 'package:flutter_autonomous_template/core/router/app_router.gr.dart';
import 'package:flutter_autonomous_template/core/theme/app_colors.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
        isDark ? DiscordColors.backgroundDark : DiscordColors.backgroundLight;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(l10n.settings),
        backgroundColor: backgroundColor,
      ),
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
          _buildAccountSection(context, ref, l10n),
          if (kDebugMode) ...[
            const VGap.lg(),
            const Divider(),
            const VGap.md(),
            _buildDebugSection(context, ref, l10n),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? DiscordColors.textPrimaryDark : DiscordColors.textPrimaryLight;

    return Text(
      title,
      style: TextStyle(
        color: textColor,
        fontSize: 16,
        fontWeight: FontWeight.w600,
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, l10n.theme),
        const VGap.sm(),
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
    final isSelected = value == currentValue;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? DiscordColors.textPrimaryDark : DiscordColors.textPrimaryLight;

    return DiscordListTile(
      leading: Icon(
        icon,
        color: isSelected ? DiscordColors.blurple : textColor,
      ),
      title: title,
      titleStyle: TextStyle(
        color: isSelected ? DiscordColors.blurple : textColor,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
      ),
      trailing: isSelected
          ? const Icon(Icons.check, color: DiscordColors.blurple)
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, l10n.language),
        const VGap.sm(),
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
    final isSelected = locale == currentLocale;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? DiscordColors.textPrimaryDark : DiscordColors.textPrimaryLight;

    return DiscordListTile(
      title: title,
      titleStyle: TextStyle(
        color: isSelected ? DiscordColors.blurple : textColor,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
      ),
      trailing: isSelected
          ? const Icon(Icons.check, color: DiscordColors.blurple)
          : null,
      onTap: () {
        ref.read(settingsProvider.notifier).setLocale(locale);
      },
    );
  }

  Widget _buildAboutSection(BuildContext context, AppLocalizations l10n) {
    return DiscordListTile(
      leading: const Icon(Icons.info_outline),
      title: 'About',
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

  Widget _buildAccountSection(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) {
    final currentUser = ref.watch(currentUserProvider);
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState.isLoading;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, l10n.account),
        const VGap.sm(),
        if (currentUser != null) ...[
          DiscordListTile(
            leading: DiscordAvatar(
              initials: currentUser.name.isNotEmpty
                  ? currentUser.name[0].toUpperCase()
                  : '?',
              status: DiscordStatus.online,
            ),
            title: currentUser.name,
            subtitle: currentUser.email,
          ),
        ],
        DiscordListTile(
          leading: const Icon(Icons.logout, color: DiscordColors.red),
          title: l10n.signOut,
          titleStyle: const TextStyle(color: DiscordColors.red),
          onTap: isLoading
              ? null
              : () async {
                  final confirmed = await DiscordConfirmSheet.show(
                    context: context,
                    title: l10n.signOut,
                    description: l10n.signOutConfirm,
                    confirmLabel: l10n.signOut,
                    cancelLabel: l10n.cancel,
                    isDestructive: true,
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

  Widget _buildDebugSection(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) {
    final config = BuildConfig.fromEnvironment();
    final debugSettings = ref.watch(debugSettingsProvider);
    final debugNotifier = ref.read(debugSettingsProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.bug_report, color: DiscordColors.red),
            const HGap.sm(),
            Text(
              l10n.debugInfo,
              style: const TextStyle(
                color: DiscordColors.red,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const VGap.sm(),
        _buildDebugItem(context, 'Flavor', config.flavor.name.toUpperCase()),
        _buildDebugItem(context, 'App Name', config.appName),
        _buildDebugItem(context, 'Base URL', config.baseUrl),
        const VGap.md(),
        const Divider(),
        const VGap.sm(),
        Text(
          l10n.repositoryDebug,
          style: const TextStyle(
            color: DiscordColors.red,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const VGap.sm(),
        DiscordSwitchListTile(
          title: l10n.useDebugRepository,
          subtitle: l10n.useDebugRepositoryDesc,
          value: debugSettings.useDebugRepository,
          onChanged: (_) => debugNotifier.toggleUseDebugRepository(),
        ),
        const VGap.sm(),
        Center(
          child: DiscordPillButton(
            label: l10n.resetToDefaults,
            icon: Icons.refresh,
            onPressed: debugNotifier.resetToDefaults,
            variant: DiscordButtonVariant.outlined,
          ),
        ),
        const VGap.lg(),
        const Divider(),
        const VGap.sm(),
        const Text(
          'Component Gallery',
          style: TextStyle(
            color: DiscordColors.red,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const VGap.sm(),
        DiscordListTile(
          leading: const Icon(Icons.palette_outlined),
          title: 'Discord Components',
          subtitle: 'Preview Discord-style UI components',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) => const DiscordComponentGallery(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildDebugItem(BuildContext context, String label, String value) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? DiscordColors.textPrimaryDark : DiscordColors.textPrimaryLight;
    final mutedColor =
        isDark ? DiscordColors.textMutedDark : DiscordColors.textMutedLight;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: mutedColor,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
