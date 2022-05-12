import 'package:clock/clock.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

// Main App
import 'app.dart';
import 'src/config/config.dart';
import 'src/core/local/key_value_storage_base.dart';
import 'src/core/local/path_provider_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await KeyValueStorageBase.init();
  await PathProviderService.init();
  debugPrint = setDebugPrint;
  await SentryFlutter.init(
    (options) {
      options
        ..dsn = Config.sentryDSN
        ..tracesSampleRate = kDebugMode ? 1.0 : 0.7;
    },
    appRunner: () => runApp(
      DefaultAssetBundle(
        bundle: SentryAssetBundle(),
        child: const MyApp(),
      ),
    ),
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

void setDebugPrint(String? message, {int? wrapWidth}) {
  final date = clock.now();
  var msg = '${date.year}/${date.month}/${date.day}';
  msg += ' ${date.hour}:${date.minute}:${date.second}';
  msg += ' $message';
  debugPrintSynchronously(msg, wrapWidth: wrapWidth);
}
