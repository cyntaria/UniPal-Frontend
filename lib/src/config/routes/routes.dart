// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';

/// A utility class that holds screen names for named navigation.
/// This class has no constructor and all variables are `static`.
@immutable
class Routes {
  const Routes._();

  /// The name of the route for app startup screen
  static const String AppStartupScreen = '/app-startup-screen';

  /// The name of the route for unrecognized route screen
  static const String RouteNotFoundScreen = '/route-not-found-screen';

  /// The name of the route for login screen.
  static const String LoginScreen = '/login-screen';

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
  static const String StudentProfileScreen = '/student-profile-screen';

  /// The name of the route for user preferences screen.
  static const String UserPreferencesScreen = '/user-preferences-screen';

  /// The name of the route for my sent/received friend requests screen.
  static const String MyFriendRequestsScreen = '/my-friend-requests-screen';

  /// The name of the route for timetable schedule generator screen.
  static const String SchedulerScreen = '/scheduler-screen';

  /// The name of the route for generated timetables screen.
  static const String GeneratedTimetablesScreen = '/generated-timetables-screen';

  /// The name of the route for my/students' timetables screen.
  static const String TimetablesScreen = '/timetables-screen';

  /// The name of the route for timetable details screen.
  static const String TimetableDetailsScreen = '/timetable-details-screen';

  /// The name of the route for teacher reviews screen.
  static const String TeacherReviewsScreen = '/teacher-reviews-screen';

  /// The name of the route for timetable details screen.
  static const String AddEditTeacherReviewScreen = '/add-edit-teacher-review-screen';
}
