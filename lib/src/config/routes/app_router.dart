// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';

// Screens
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/qr_scanner_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/home/app_startup_screen.dart';
import '../../features/home/home_screen.dart';

// Routing
import './routes.dart';

// Helpers
import '../../helpers/typedefs.dart';

/// A utility class provides basic methods for navigation.
/// This class has no constructor and all variables are `static`.
@immutable
class AppRouter {
  const AppRouter._();

  static final Map<String, RouteBuilder> _routesMap = {
    Routes.AppStartupScreen: (_) => const AppStartupScreen(),
    Routes.HomeScreen: (_) => const HomeScreen(),
    Routes.RouteNotFoundScreen: (_) => const SizedBox.shrink(),
    Routes.LoginScreen: (_) => const LoginScreen(),
    Routes.RegisterScreen: (_) => const RegisterScreen(),
    Routes.QrScannerScreen: (_) => const QrScannerScreen(),
    Routes.ForgotPasswordScreen: (_) => const SizedBox.shrink(),
    Routes.ChangePasswordScreen: (_) => const SizedBox.shrink(),
    Routes.PostsFeedScreen: (_) => const SizedBox.shrink(),
    Routes.AddEditPostScreen: (_) => const SizedBox.shrink(),
    Routes.ActivitiesFeedScreen: (_) => const SizedBox.shrink(),
    Routes.AddEditActivityScreen: (_) => const SizedBox.shrink(),
    Routes.StudentFinderScreen: (_) => const SizedBox.shrink(),
    Routes.StudentProfileScreen: (_) => const SizedBox.shrink(),
    Routes.UserPreferencesScreen: (_) => const SizedBox.shrink(),
    Routes.MyFriendRequestsScreen: (_) => const SizedBox.shrink(),
    Routes.SchedulerScreen: (_) => const SizedBox.shrink(),
    Routes.GeneratedTimetablesScreen: (_) => const SizedBox.shrink(),
    Routes.TimetablesScreen: (_) => const SizedBox.shrink(),
    Routes.TimetableDetailsScreen: (_) => const SizedBox.shrink(),
    Routes.TeacherReviewsScreen: (_) => const SizedBox.shrink(),
    Routes.AddEditTeacherReviewScreen: (_) => const SizedBox.shrink(),
  };

  /// The global key used to access navigator without context
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// The name of the route that loads on app startup
  static const String initialRoute = Routes.AppStartupScreen;

  /// This method is used when the app is navigating using named routes.
  ///
  /// It maps each route name to a specific screen route.
  ///
  /// In case of unknown route name, it returns a route indicating error.
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    return MaterialPageRoute<dynamic>(
      builder:
          _routesMap[settings.name] ?? _routesMap[Routes.RouteNotFoundScreen]!,
      settings: RouteSettings(
        name: _routesMap.containsKey(settings.name)
            ? settings.name
            : Routes.RouteNotFoundScreen,
        arguments: settings.arguments,
      ),
    );
  }

  /// This method is used to navigate to a screen using it's name
  static Future<dynamic> pushNamed(String routeName, {dynamic args}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: args);
  }

  /// This method is used to navigate back to the previous screen.
  ///
  /// The [result] can contain any value that we want to return to the previous
  /// screen.
  static Future<void> pop([dynamic result]) async {
    navigatorKey.currentState!.pop(result);
  }

  /// This method is used to navigate all the way back to a specific screen.
  ///
  /// The [routeName] is the name of the screen we want to go back to.
  static void popUntil(String routeName) {
    navigatorKey.currentState!.popUntil(ModalRoute.withName(routeName));
  }

  /// This method is used to navigate all the way back to the first screen
  /// shown on startup i.e. the [initialRoute].
  static void popUntilRoot() {
    navigatorKey.currentState!.popUntil(ModalRoute.withName(initialRoute));
  }
}
