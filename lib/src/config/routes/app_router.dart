// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';

// Routing
import './routes.dart';

/// A utility class provides basic methods for navigation.
/// This class has no constructor and all variables are `static`.
@immutable
class AppRouter {
  const AppRouter._();

  /// The global key used to access navigator without context
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// This method is used when the app is navigating using named routes.
  ///
  /// It maps each route name to a specific screen route.
  ///
  /// In case of unknown route name, it returns a route indicating error.
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    return MaterialPageRoute<dynamic>(
      builder: Routes.getRoute(settings.name),
      settings: RouteSettings(
        name: Routes.routeExists(settings.name)
            ? settings.name
            : Routes.fallbackRoute,
        arguments: settings.arguments,
      ),
    );
  }

  /// This method is used to navigate to a screen using it's name
  static Future<dynamic> pushNamed(String routeName, {dynamic args}) {
    return navigatorKey.currentState!.pushNamed(
      routeName,
      arguments: args,
    );
  }

  /// This method is used to navigate to a screen using builder
  static Future<dynamic> push(Widget page) {
    return navigatorKey.currentState!.push(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  /// This method is used to navigate back to the previous screen.
  ///
  /// The [result] can contain any value that we want to return to the previous
  /// screen.
  static Future<void> pop([dynamic result]) async {
    navigatorKey.currentState!.pop(result);
  }

  /// This method is used to pop the current screen and then navigate to another
  /// screen using it's name
  static Future<dynamic> popAndPushNamed(String routeName, {dynamic args}) {
    return navigatorKey.currentState!.popAndPushNamed(
      routeName,
      arguments: args,
    );
  }

  /// This method is used to navigate all the way back to a specific screen.
  ///
  /// The [routeName] is the name of the screen we want to go back to.
  static void popUntil(String routeName) {
    navigatorKey.currentState!.popUntil(
      ModalRoute.withName(routeName),
    );
  }

  /// This method is used to navigate all the way back to the first screen
  /// shown on startup i.e. the [initialRoute].
  static void popUntilRoot() {
    navigatorKey.currentState!.popUntil(
      ModalRoute.withName(Routes.initialRoute),
    );
  }
}
