import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';

import 'package:flutter_autonomous_template/app.dart';
import 'package:flutter_autonomous_template/core/dev_tools/talker.dart';
import 'package:flutter_autonomous_template/features/todo/providers/todo_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      observers: [
        if (kDebugMode) TalkerRiverpodObserver(talker: talker),
      ],
      child: const App(),
    ),
  );
}
