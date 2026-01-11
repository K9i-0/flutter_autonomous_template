import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_autonomous_template/core/components/app_button.dart';
import 'package:flutter_autonomous_template/core/components/app_text_field.dart';
import 'package:flutter_autonomous_template/core/l10n/app_localizations.dart';
import 'package:flutter_autonomous_template/core/router/app_router.gr.dart';
import 'package:flutter_autonomous_template/core/theme/app_radius.dart';
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.loginFailed(error.toString())),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        },
      );
    });

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: AppSpacing.screenPadding,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const VGap.md(),
                _buildWelcomeBanner(context),
                const VGap.xl(),
                _buildHeader(context, l10n),
                const VGap.xxl(),
                _buildEmailField(l10n),
                const VGap.md(),
                _buildPasswordField(l10n),
                const VGap.xl(),
                AppButton(
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

  Widget _buildWelcomeBanner(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.secondary,
            theme.colorScheme.secondary.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: AppRadius.banner,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.secondary.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: AppRadius.smAll,
            ),
            child: Icon(
              Icons.local_offer,
              color: theme.colorScheme.onSecondary,
              size: 28,
            ),
          ),
          const HGap.md(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Special Offer!',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const VGap.xs(),
                Text(
                  'Complete your tasks and earn rewards',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSecondary.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: theme.colorScheme.onSecondary.withOpacity(0.7),
            size: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);

    return Column(
      children: [
        // McDonald's-style logo area with red and yellow accents
        Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                theme.colorScheme.primary.withOpacity(0.1),
                Colors.transparent,
              ],
              radius: 1.5,
            ),
          ),
          child: Icon(
            Icons.check_circle,
            size: 80,
            color: theme.colorScheme.primary,
          ),
        ),
        const VGap.md(),
        Text(
          l10n.welcomeBack,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const VGap.sm(),
        Text(
          l10n.signInToContinue,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.outline,
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField(AppLocalizations l10n) {
    return AppTextField(
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
    return AppTextField(
      controller: _passwordController,
      label: l10n.password,
      hint: l10n.passwordHint,
      obscureText: _obscurePassword,
      textInputAction: TextInputAction.done,
      prefixIcon: const Icon(Icons.lock_outlined),
      suffixIcon: IconButton(
        icon: Icon(
          _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
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
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 20,
                color: theme.colorScheme.primary,
              ),
              const HGap.sm(),
              Text(
                l10n.demoMode,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const VGap.sm(),
          Text(
            l10n.demoModeDescription,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSignIn() async {
    if (!_formKey.currentState!.validate()) return;

    await ref.read(authNotifierProvider.notifier).signIn(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
  }
}
