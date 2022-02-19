import 'package:flutter/foundation.dart';

/// A utility class that holds constants for exposing loaded
/// dart environment variables.
/// This class has no constructor and all variables are `static`.
@immutable
class Config {
  const Config._();

  /// The base url of our REST API, to which all the requests will be sent.
  /// It is supplied at the time of building the apk or running the app:
  /// ```
  /// flutter build apk --debug --dart-define=BASE_URL=www.some_url.com
  /// ```
  /// OR
  /// ```
  /// flutter run --dart-define=BASE_URL=www.some_url.com
  /// ```
  static const baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'localhost:3000/api/v1',
  );

  /// The client key for sentry SDK. The DSN tells the SDK where to
  /// send the events to.
  /// 
  /// It is supplied at the time of building the apk or running the app:
  /// ```
  /// flutter build apk --debug --dart-define=SENTRY_DSN=www.some_url.com
  /// ```
  /// OR
  /// ```
  /// flutter run --dart-define=SENTRY_DSN=www.some_url.com
  /// ```
  static const sentryDSN = String.fromEnvironment(
    'SENTRY_DSN',
    defaultValue: 'https://some-number.ingest.sentry.io/number',
  );
}
