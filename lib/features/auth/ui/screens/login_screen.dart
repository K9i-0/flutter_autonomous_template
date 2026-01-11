import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_autonomous_template/core/components/discord/discord_components.dart';
import 'package:flutter_autonomous_template/core/l10n/app_localizations.dart';
import 'package:flutter_autonomous_template/core/router/app_router.gr.dart';
import 'package:flutter_autonomous_template/core/theme/app_colors.dart';
import 'package:flutter_autonomous_template/core/theme/app_spacing.dart';
import 'package:flutter_autonomous_template/features/auth/data/models/user.dart';
import 'package:flutter_autonomous_template/features/auth/providers/auth_provider.dart';

@RoutePage()
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState.isLoading;
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
        isDark ? DiscordColors.backgroundDark : DiscordColors.backgroundLight;

    // Listen for auth state changes
    ref.listen<AsyncValue<User?>>(authStateProvider, (previous, next) {
      next.whenData((user) {
        if (user != null && mounted) {
          // Navigate to main screen when authenticated
          context.router.replaceAll([const MainRoute()]);
        }
      });
    });

    // Listen for errors
    ref.listen<AsyncValue<void>>(authNotifierProvider, (previous, next) {
      next.whenOrNull(
        error: (error, _) {
          DiscordSnackbar.showError(
            context,
            l10n.loginFailed(error.toString()),
          );
        },
      );
    });

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: AppSpacing.screenPadding,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const VGap.xxl(),
                _buildHeader(context, l10n),
                const VGap.xxl(),
                _buildEmailField(l10n),
                const VGap.md(),
                _buildPasswordField(l10n),
                const VGap.xl(),
                DiscordPillButton(
                  label: l10n.signIn,
                  onPressed: isLoading ? null : _handleSignIn,
                  isLoading: isLoading,
                  isExpanded: true,
                ),
                const VGap.lg(),
                _buildDemoHint(context, l10n),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations l10n) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? DiscordColors.textPrimaryDark : DiscordColors.textPrimaryLight;
    final mutedColor =
        isDark ? DiscordColors.textMutedDark : DiscordColors.textMutedLight;

    return Column(
      children: [
        Icon(
          Icons.check_circle_outline,
          size: 80,
          color: DiscordColors.blurple,
        ),
        const VGap.lg(),
        Text(
          l10n.welcomeBack,
          style: TextStyle(
            color: textColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const VGap.sm(),
        Text(
          l10n.signInToContinue,
          style: TextStyle(
            color: mutedColor,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField(AppLocalizations l10n) {
    return DiscordTextField(
      controller: _emailController,
      label: l10n.email,
      hint: l10n.emailHint,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      prefixIcon: const Icon(Icons.email_outlined),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return l10n.emailRequired;
        }
        if (!value.contains('@')) {
          return l10n.emailInvalid;
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField(AppLocalizations l10n) {
    return DiscordTextField(
      controller: _passwordController,
      label: l10n.password,
      hint: l10n.passwordHint,
      obscureText: _obscurePassword,
      textInputAction: TextInputAction.done,
      prefixIcon: const Icon(Icons.lock_outlined),
      suffixIcon: IconButton(
        icon: Icon(
          _obscurePassword
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
        ),
        onPressed: () {
          setState(() {
            _obscurePassword = !_obscurePassword;
          });
        },
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return l10n.passwordRequired;
        }
        return null;
      },
      onSubmitted: (_) => _handleSignIn(),
    );
  }

  Widget _buildDemoHint(BuildContext context, AppLocalizations l10n) {
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState.isLoading;

    return DiscordInfoCard(
      title: l10n.demoMode,
      icon: Icons.info_outline,
      description: l10n.demoModeDescription,
      child: kDebugMode
          ? SizedBox(
              width: double.infinity,
              child: DiscordPillButton(
                label: l10n.debugQuickLogin,
                icon: Icons.flash_on,
                onPressed: isLoading ? null : _handleDebugSignIn,
                variant: DiscordButtonVariant.outlined,
              ),
            )
          : null,
    );
  }

  Future<void> _handleSignIn() async {
    if (!_formKey.currentState!.validate()) return;

    await ref
        .read(authNotifierProvider.notifier)
        .signIn(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
  }

  Future<void> _handleDebugSignIn() async {
    await ref
        .read(authNotifierProvider.notifier)
        .signIn(email: 'demo@example.com', password: 'demo');
  }
}
