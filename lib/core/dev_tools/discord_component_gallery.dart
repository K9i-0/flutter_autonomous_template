import 'package:flutter/material.dart';

import 'package:flutter_autonomous_template/core/components/discord/discord_components.dart';
import 'package:flutter_autonomous_template/core/theme/app_colors.dart';
import 'package:flutter_autonomous_template/core/theme/app_spacing.dart';

/// Discord Component Gallery
///
/// A development screen to preview and test all Discord-style components.
/// Access from debug menu in Settings screen.
class DiscordComponentGallery extends StatefulWidget {
  const DiscordComponentGallery({super.key});

  @override
  State<DiscordComponentGallery> createState() =>
      _DiscordComponentGalleryState();
}

class _DiscordComponentGalleryState extends State<DiscordComponentGallery> {
  int _segmentIndex = 0;
  int _tabIndex = 0;
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
        isDark ? DiscordColors.backgroundDark : DiscordColors.backgroundLight;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Discord Components'),
        backgroundColor: backgroundColor,
      ),
      body: ListView(
        padding: AppSpacing.screenPadding,
        children: [
          _buildSection('Pill Buttons', _buildPillButtons()),
          _buildSection('Text Fields', _buildTextFields()),
          _buildSection('Segmented Control', _buildSegmentedControl()),
          _buildSection('Tab Bar', _buildTabBar()),
          _buildSection('List Tiles', _buildListTiles()),
          _buildSection('Avatars', _buildAvatars()),
          _buildSection('Bottom Sheet', _buildBottomSheetDemo()),
        ],
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark
            ? DiscordColors.textPrimaryDark
            : DiscordColors.textPrimaryLight;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const VGap.md(),
        content,
        const VGap.xl(),
      ],
    );
  }

  Widget _buildPillButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DiscordPillButton(
          label: 'Filled Button',
          onPressed: () {},
          variant: DiscordButtonVariant.filled,
        ),
        const VGap.sm(),
        DiscordPillButton(
          label: 'Outlined Button',
          onPressed: () {},
          variant: DiscordButtonVariant.outlined,
        ),
        const VGap.sm(),
        DiscordPillButton(
          label: 'Gray Button',
          onPressed: () {},
          variant: DiscordButtonVariant.gray,
        ),
        const VGap.sm(),
        DiscordPillButton(
          label: 'With Icon',
          onPressed: () {},
          icon: Icons.add,
        ),
        const VGap.sm(),
        const DiscordPillButton(
          label: 'Loading...',
          isLoading: true,
        ),
        const VGap.sm(),
        const DiscordPillButton(label: 'Disabled'),
      ],
    );
  }

  Widget _buildTextFields() {
    return Column(
      children: [
        DiscordTextField(
          label: 'Email',
          hint: 'Enter your email',
          prefixIcon: const Icon(Icons.email_outlined),
        ),
        const VGap.md(),
        DiscordTextField(
          label: 'Password',
          hint: 'Enter your password',
          obscureText: true,
          prefixIcon: const Icon(Icons.lock_outlined),
          suffixIcon: IconButton(
            icon: const Icon(Icons.visibility_outlined),
            onPressed: () {},
          ),
        ),
        const VGap.md(),
        DiscordTextField(
          controller: _textController,
          hint: 'Search...',
          prefixIcon: const Icon(Icons.search),
        ),
      ],
    );
  }

  Widget _buildSegmentedControl() {
    return DiscordSegmentedControl(
      segments: const ['Phone', 'Email'],
      selectedIndex: _segmentIndex,
      onChanged: (index) => setState(() => _segmentIndex = index),
    );
  }

  Widget _buildTabBar() {
    return DiscordTabBar(
      tabs: const ['Messages', 'Media', 'Pinned', 'Links', 'Files'],
      selectedIndex: _tabIndex,
      onChanged: (index) => setState(() => _tabIndex = index),
    );
  }

  Widget _buildListTiles() {
    return Column(
      children: [
        DiscordListTile(
          leading: const DiscordAvatar(
            initials: 'JD',
            status: DiscordStatus.online,
          ),
          title: 'John Doe',
          subtitle: 'Hey! How are you?',
          trailing: const Text(
            '2m',
            style: TextStyle(color: DiscordColors.textMutedLight),
          ),
          onTap: () {},
          showDivider: true,
        ),
        DiscordListTile(
          leading: const DiscordAvatar(
            initials: 'AS',
            backgroundColor: DiscordColors.green,
            status: DiscordStatus.idle,
          ),
          title: 'Alice Smith',
          subtitle: 'See you later!',
          trailing: const Text(
            '1h',
            style: TextStyle(color: DiscordColors.textMutedLight),
          ),
          onTap: () {},
          showDivider: true,
        ),
        DiscordListTile(
          leading: const DiscordAvatar(
            initials: 'BW',
            backgroundColor: DiscordColors.fuchsia,
            status: DiscordStatus.dnd,
          ),
          title: 'Bob Wilson',
          subtitle: 'Do not disturb',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildAvatars() {
    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.md,
      children: const [
        DiscordAvatar(initials: 'A', status: DiscordStatus.online),
        DiscordAvatar(
          initials: 'B',
          backgroundColor: DiscordColors.green,
          status: DiscordStatus.idle,
        ),
        DiscordAvatar(
          initials: 'C',
          backgroundColor: DiscordColors.fuchsia,
          status: DiscordStatus.dnd,
        ),
        DiscordAvatar(
          initials: 'D',
          backgroundColor: DiscordColors.yellow,
          status: DiscordStatus.offline,
        ),
        DiscordAvatar(initials: 'E', size: 56),
      ],
    );
  }

  Widget _buildBottomSheetDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DiscordPillButton(
          label: 'Show Bottom Sheet',
          onPressed: () => _showDemoBottomSheet(),
          variant: DiscordButtonVariant.filled,
        ),
        const VGap.sm(),
        DiscordPillButton(
          label: 'Show Confirm Sheet',
          onPressed: () => _showConfirmSheet(),
          variant: DiscordButtonVariant.outlined,
        ),
      ],
    );
  }

  void _showDemoBottomSheet() {
    DiscordBottomSheet.show(
      context: context,
      title: 'Enable Notifications',
      description:
          'Receive push notifications for messages, mentions, friend requests, and other Discord activities.',
      illustration: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: DiscordColors.blurple.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.notifications_outlined,
          size: 40,
          color: DiscordColors.blurple,
        ),
      ),
      primaryAction: const DiscordBottomSheetAction(label: 'Enable'),
      secondaryAction: const DiscordBottomSheetAction(label: 'Not Now'),
    );
  }

  void _showConfirmSheet() {
    DiscordConfirmSheet.show(
      context: context,
      title: 'Sign Out',
      description: 'Are you sure you want to sign out?',
      confirmLabel: 'Sign Out',
      cancelLabel: 'Cancel',
    );
  }
}
