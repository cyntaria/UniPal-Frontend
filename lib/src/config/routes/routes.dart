// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';

// Screens
import '../../features/auth/screens/login_screen.dart' as s;
import '../../features/auth/screens/qr_scanner_screen.dart' as s;
import '../../features/auth/screens/register_screen.dart' as s;
import '../../features/app_startup_screen.dart' as s;
import '../../features/home/screens/home_screen.dart' as s;
import '../../features/posts/screens/add_edit_post_screen.dart' as s;
import '../../features/profile/screens/profile_screen.dart' as s;
import '../../features/profile/screens/update_preferences_screen.dart' as s;
import '../../features/timetables/screens/generated_timetables_screen.dart' as s;

// Helpers
import '../../helpers/typedefs.dart';

/// A utility class that holds screen names for named navigation.
/// This class has no constructor and all variables are `static`.
@immutable
class Routes {
  const Routes._();

  /// The route to be loaded when app launches
  static const String initialRoute = AppStartupScreen;

  /// The route to be loaded in case of unrecognized route name
  static const String fallbackRoute = RouteNotFoundScreen;

  /// The name of the route for app startup screen
  static const String AppStartupScreen = '/app-startup-screen';

  /// The name of the route for home dashboard screen
  static const String HomeScreen = '/home-screen';

  /// The name of the route for unrecognized route screen
  static const String RouteNotFoundScreen = '/route-not-found-screen';

  /// The name of the route for login screen.
  static const String LoginScreen = '/login-screen';

  /// The name of the route for qr scanner screen.
  static const String QrScannerScreen = '/qr-scanner-screen';

  /// The name of the route for register screen.
  static const String RegisterScreen = '/register-screen';

  /// The name of the route for forgot password screen.
  static const String ForgotPasswordScreen = '/forgot-password-screen';

  /// The name of the route for change password screen.
  static const String ChangePasswordScreen = '/change-password-screen';

  /// The name of the route for posts feed screen.
  static const String PostsFeedScreen = '/posts-feed-screen';

  /// The name of the route for adding or editing a post screen.
  static const String AddEditPostScreen = '/add-edit-post-screen';

  /// The name of the route for activities feed screen.
  static const String ActivitiesFeedScreen = '/activities-feed-screen';

  /// The name of the route for adding or editing an activity screen.
  static const String AddEditActivityScreen = '/add-edit-activity-screen';

  /// The name of the route for student finder screen.
  static const String StudentFinderScreen = '/student-finder-screen';

  /// The name of the route for student profile screen.
  static const String ProfileScreen = '/student-profile-screen';

  /// The name of the route for user preferences screen.
  static const String UpdatePreferencesScreen = '/update-preferences-screen';

  /// The name of the route for my sent/received friend requests screen.
  static const String MyFriendRequestsScreen = '/my-friend-requests-screen';

  /// The name of the route for timetable schedule generator screen.
  static const String SchedulerScreen = '/scheduler-screen';

  /// The name of the route for generated timetables screen.
  static const String GeneratedTimetablesScreen =
      '/generated-timetables-screen';

  /// The name of the route for my/students' timetables screen.
  static const String TimetablesScreen = '/timetables-screen';

  /// The name of the route for teacher reviews screen.
  static const String TeacherReviewsScreen = '/teacher-reviews-screen';

  /// The name of the route for timetable details screen.
  static const String AddEditTeacherReviewScreen =
      '/add-edit-teacher-review-screen';

  static final Map<String, RouteBuilder> _routesMap = {
    AppStartupScreen: (_) => const s.AppStartupScreen(),
    HomeScreen: (_) => const s.HomeScreen(),
    LoginScreen: (_) => const s.LoginScreen(),
    RegisterScreen: (_) => const s.RegisterScreen(),
    QrScannerScreen: (_) => const s.QrScannerScreen(),
    ProfileScreen: (_) => const s.ProfileScreen(),
    UpdatePreferencesScreen: (_) => const s.UpdatePreferencesScreen(),
    AddEditPostScreen: (_) => const s.AddEditPostScreen(),
    RouteNotFoundScreen: (_) => const SizedBox.shrink(),
    ForgotPasswordScreen: (_) => const SizedBox.shrink(),
    ChangePasswordScreen: (_) => const SizedBox.shrink(),
    AddEditActivityScreen: (_) => const SizedBox.shrink(),
    GeneratedTimetablesScreen: (_) => const s.GeneratedTimetablesScreen(),
    TimetablesScreen: (_) => const SizedBox.shrink(),
    TeacherReviewsScreen: (_) => const SizedBox.shrink(),
    AddEditTeacherReviewScreen: (_) => const SizedBox.shrink(),
  };

  static RouteBuilder getRoute(String? routeName) {
    return routeExists(routeName)
        ? _routesMap[routeName]!
        : _routesMap[Routes.RouteNotFoundScreen]!;
  }

  static bool routeExists(String? routeName) {
    return _routesMap.containsKey(routeName);
  }
}
