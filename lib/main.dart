import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';

import 'package:flutter_autonomous_template/app.dart';
import 'package:flutter_autonomous_template/core/dev_tools/talker.dart';

void main() {
  runApp(
    ProviderScope(
      observers: [
        if (kDebugMode) TalkerRiverpodObserver(talker: talker),
      ],
      child: const App(),
    ),
  );
}
