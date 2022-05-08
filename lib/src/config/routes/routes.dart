// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';

// Screens
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/qr_scanner_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/app_startup_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/posts/screens/add_edit_post_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/profile/screens/update_preferences_screen.dart';
import '../../features/timetables/screens/generated_timetables_screen.dart';

// Helpers
import '../../helpers/typedefs.dart';

/// A utility class that holds screen names for named navigation.
/// This class has no constructor and all variables are `static`.
@immutable
class Routes {
  const Routes._();

  /// The route to be loaded when app launches
  static const String initialRoute = AppStartupScreenRoute;

  /// The route to be loaded in case of unrecognized route name
  static const String fallbackRoute = NotFoundScreenRoute;

  /// The name of the route for app startup screen
  static const String AppStartupScreenRoute = '/app-startup-screen';

  /// The name of the route for home dashboard screen
  static const String HomeScreenRoute = '/home-screen';

  /// The name of the route for unrecognized route screen
  static const String NotFoundScreenRoute = '/route-not-found-screen';

  /// The name of the route for login screen.
  static const String LoginScreenRoute = '/login-screen';

  /// The name of the route for qr scanner screen.
  static const String QrScannerScreenRoute = '/qr-scanner-screen';

  /// The name of the route for register screen.
  static const String RegisterScreenRoute = '/register-screen';

  /// The name of the route for forgot password screen.
  static const String ForgotPasswordScreenRoute = '/forgot-password-screen';

  /// The name of the route for change password screen.
  static const String ChangePasswordScreenRoute = '/change-password-screen';

  /// The name of the route for posts feed screen.
  static const String PostsFeedScreenRoute = '/posts-feed-screen';

  /// The name of the route for adding or editing a post screen.
  static const String AddEditPostScreenRoute = '/add-edit-post-screen';

  /// The name of the route for activities feed screen.
  static const String ActivitiesFeedScreenRoute = '/activities-feed-screen';

  /// The name of the route for adding or editing an activity screen.
  static const String AddEditActivityScreenRoute = '/add-edit-activity-screen';

  /// The name of the route for student finder screen.
  static const String StudentFinderScreenRoute = '/student-finder-screen';

  /// The name of the route for student profile screen.
  static const String ProfileScreenRoute = '/student-profile-screen';

  /// The name of the route for user preferences screen.
  static const String UpdatePreferencesScreenRoute =
      '/update-preferences-screen';

  /// The name of the route for my sent/received friend requests screen.
  static const String MyFriendRequestsScreenRoute =
      '/my-friend-requests-screen';

  /// The name of the route for timetable schedule generator screen.
  static const String SchedulerScreenRoute = '/scheduler-screen';

  /// The name of the route for generated timetables screen.
  static const String GeneratedTimetablesScreenRoute =
      '/generated-timetables-screen';

  /// The name of the route for my/students' timetables screen.
  static const String TimetablesScreenRoute = '/timetables-screen';

  /// The name of the route for teacher reviews screen.
  static const String TeacherReviewsScreenRoute = '/teacher-reviews-screen';

  /// The name of the route for timetable details screen.
  static const String AddEditTeacherReviewScreenRoute =
      '/add-edit-teacher-review-screen';

  static final Map<String, RouteBuilder> _routesMap = {
    AppStartupScreenRoute: (_) => const AppStartupScreen(),
    HomeScreenRoute: (_) => const HomeScreen(),
    LoginScreenRoute: (_) => const LoginScreen(),
    RegisterScreenRoute: (_) => const RegisterScreen(),
    QrScannerScreenRoute: (_) => const QrScannerScreen(),
    ProfileScreenRoute: (_) => const ProfileScreen(),
    UpdatePreferencesScreenRoute: (_) => const UpdatePreferencesScreen(),
    AddEditPostScreenRoute: (_) => const AddEditPostScreen(),
    NotFoundScreenRoute: (_) => const SizedBox.shrink(),
    ForgotPasswordScreenRoute: (_) => const SizedBox.shrink(),
    ChangePasswordScreenRoute: (_) => const SizedBox.shrink(),
    AddEditActivityScreenRoute: (_) => const SizedBox.shrink(),
    GeneratedTimetablesScreenRoute: (_) => const GeneratedTimetablesScreen(),
    TimetablesScreenRoute: (_) => const SizedBox.shrink(),
    TeacherReviewsScreenRoute: (_) => const SizedBox.shrink(),
    AddEditTeacherReviewScreenRoute: (_) => const SizedBox.shrink(),
  };

  static RouteBuilder getRoute(String? routeName) {
    return routeExists(routeName)
        ? _routesMap[routeName]!
        : _routesMap[Routes.NotFoundScreenRoute]!;
  }

  static bool routeExists(String? routeName) {
    return _routesMap.containsKey(routeName);
  }
}
