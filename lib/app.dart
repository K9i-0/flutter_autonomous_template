import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:flutter_autonomous_template/core/dev_tools/talker.dart';
import 'package:flutter_autonomous_template/core/l10n/app_localizations.dart';
import 'package:flutter_autonomous_template/core/router/app_router.dart';
import 'package:flutter_autonomous_template/core/theme/app_theme.dart';
import 'package:flutter_autonomous_template/features/settings/providers/settings_provider.dart';

/// Application router instance
final appRouter = AppRouter();

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp.router(
      title: 'Flutter App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: appRouter.config(
        navigatorObservers: () => [if (kDebugMode) TalkerRouteObserver(talker)],
      ),
    );
  }
}
