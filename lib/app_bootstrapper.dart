import 'dart:async';

import 'package:clock/clock.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

// Config
import 'firebase_options.dart';
import 'src/config/config.dart';

// Services
import 'src/core/local/key_value_storage_base.dart';
import 'src/core/local/path_provider_service.dart';

/// A wrapper class that contains methods to bootstrap the app launch.
///
/// It initializes the important services at app startup to allow
/// syncronous access to them later on.
class AppBootstrapper {
  const AppBootstrapper._();

  /// Initializer for important and asyncronous app services
  /// Should be called in main after `WidgetsBinding.FlutterInitialized()`.
  ///
  /// [mainAppWidget] is the first widget that loads on app startup.
  /// [runApp] is the main app binding method that launches our [mainAppWidget].
  static Future<void> init({
    required Widget mainAppWidget,
    required void Function(Widget) runApp,
  }) async {
    // For preparing the key-value mem cache
    await KeyValueStorageBase.init();

    // For preparing to read application directory paths
    await PathProviderService.init();

    // For prettyifying console debug messages
    debugPrint = _prettifyDebugPrint;

    // Initialize firebase SDK
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // For preparing the error monitoring SDK and loading
    // up the `runApp` method in a guarded zone
    await _setupSentrySDK(runApp, mainAppWidget);

    // For restricting the app to portrait mode only
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  static Future<void> _setupSentrySDK(
    void Function(Widget) appRunner,
    Widget app,
  ) async {
    await SentryFlutter.init(
      (options) {
        options
          ..dsn = Config.sentryDSN
          ..tracesSampleRate = kDebugMode ? 1.0 : 0.7;
      },
      appRunner: () => appRunner(
        DefaultAssetBundle(
          bundle: SentryAssetBundle(),
          child: app,
        ),
      ),
    );
  }

  static void _prettifyDebugPrint(String? message, {int? wrapWidth}) {
    final date = clock.now();
    var msg = '${date.year}/${date.month}/${date.day}';
    msg += ' ${date.hour}:${date.minute}:${date.second}';
    msg += ' $message';
    debugPrintSynchronously(msg, wrapWidth: wrapWidth);
  }
}
