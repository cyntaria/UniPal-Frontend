// ignore_for_file: constant_identifier_names
// DO NOT USE 'dartfmt' on this file for formatting

import 'package:flutter/material.dart';

/// A utility class for getting paths for API endpoints.
/// This class has no constructor and all methods are `static`.
@immutable
class ApiEndpoint {
  const ApiEndpoint._();

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

  /// Returns the path for an authentication [endpoint].
  static String auth(AuthEndpoint endpoint) {
    var path = '/auth';
    switch (endpoint) {
      case AuthEndpoint.REGISTER: return '$path/register';
      case AuthEndpoint.LOGIN: return '$path/login';
      case AuthEndpoint.REFRESH_TOKEN: return '$path/refresh-token';
      case AuthEndpoint.CHANGE_PASSWORD: return '$path/change-password';
      case AuthEndpoint.FORGOT_PW_SEND_OTP: return '$path/forgot/send-otp';
      case AuthEndpoint.FORGOT_PW_VERIFY_OTP: return '$path/forgot/verify-otp';
      case AuthEndpoint.FORGOT_PW_RESET_PASSWORD: return '$path/forgot/reset-password';
    }
  }

  /// Returns the path for a student [endpoint].
  ///
  /// Specify student [erp] to get the path for a specific student.
  static String students(StudentEndpoint endpoint, {int? erp, int? extendedResourceId}) {
    var path = '/students';
    switch(endpoint){
      case StudentEndpoint.BASE: return path;
      case StudentEndpoint.BY_ERP: {
        assert(erp != null, 'studentErp is required for BY_ERP endpoint');
        return '$path/$erp';
      }
      case StudentEndpoint.ORGANIZED_ACTIVITIES: {
        assert(erp != null, 'studentErp is required for ORGANIZED_ACTIVITIES endpoint');
        return '$path/$erp/organized-activities';
      }
      case StudentEndpoint.ATTENDED_ACTIVITIES: {
        assert(erp != null, 'studentErp is required for ATTENDED_ACTIVITIES endpoint');
        return '$path/$erp/attended-activities';
      }
      case StudentEndpoint.SAVED_ACTIVITIES_BASE: {
        assert(erp != null, 'studentErp is required for SAVED_ACTIVITIES_BASE endpoint');
        return '$path/$erp/saved-activities';
      }
      case StudentEndpoint.SAVED_ACTIVITIES_BY_ID: {
        assert(erp != null, 'studentErp is required for SAVED_ACTIVITIES_BY_ID endpoint');
        assert(extendedResourceId != null, 'extendedResourceId is required for SAVED_ACTIVITIES_BY_ID endpoint');
        return '$path/$erp/saved-activities/$extendedResourceId';
      }
    }
  }

/// A collection of endpoints used for authentication purposes.
enum AuthEndpoint {
  /// An endpoint for registration requests.
  REGISTER,

  /// An endpoint for login requests.
  LOGIN,

  /// An endpoint for token refresh requests.
  REFRESH_TOKEN,

  /// An endpoint for change password requests.
  CHANGE_PASSWORD,

  /// An endpoint for reset password requests.
  FORGOT_PW_RESET_PASSWORD,

  /// An endpoint for forget password otp requests.
  FORGOT_PW_SEND_OTP,

  /// An endpoint for verifying forgot password otp code.
  FORGOT_PW_VERIFY_OTP,
}

/// A collection of endpoints used for students.
enum StudentEndpoint {
  /// An endpoint for students' collection requests.
  BASE,

  /// An endpoint for individual students requests.
  BY_ERP,

  /// An endpoint for a student's organized activities
  ORGANIZED_ACTIVITIES,

  /// An endpoint for a student's saved activities
  SAVED_ACTIVITIES_BASE,

  /// An endpoint for a student's specific saved activity
  SAVED_ACTIVITIES_BY_ID,

  /// An endpoint for a student's attended activities
  ATTENDED_ACTIVITIES,
}

/// A collection of endpoints used for hobbies.
enum HobbyEndpoint {
  /// An endpoint for hobbies' collection requests.
  BASE,
}

/// A collection of endpoints used for interests.
enum InterestEndpoint {
  /// An endpoint for interests' collection requests.
  BASE,
}

/// A collection of endpoints used for campuses.
enum CampusEndpoint {
  /// An endpoint for campuses' collection requests.
  BASE,
}

/// A collection of endpoints used for campus spots.
enum CampusSpotEndpoint {
  /// An endpoint for campus spots' collection requests.
  BASE,
}

/// A collection of endpoints used for programs.
enum ProgramEndpoint {
  /// An endpoint for programs' collection requests.
  BASE,
}

/// A collection of endpoints used for student statuses.
enum StudentStatusEndpoint {
  /// An endpoint for student statuses' collection requests.
  BASE,
}

/// A collection of endpoints used for activity statuses.
enum ActivityStatusEndpoint {
  /// An endpoint for activity statuses' collection requests.
  BASE,
}

/// A collection of endpoints used for activity types.
enum ActivityTypeEndpoint {
  /// An endpoint for activity types' collection requests.
  BASE,
}

/// A collection of endpoints used for reaction types.
enum ReactionTypeEndpoint {
  /// An endpoint for reaction types' collection requests.
  BASE,
}

/// A collection of endpoints used for classrooms.
enum ClassroomEndpoint {
  /// An endpoint for classrooms' collection requests.
  BASE,
}

/// A collection of endpoints used for timeslots.
enum TimeslotEndpoint {
  /// An endpoint for timeslots' collection requests.
  BASE,
}

/// A collection of endpoints used for subjects.
enum SubjectEndpoint {
  /// An endpoint for subjects' collection requests.
  BASE,
}

/// A collection of endpoints used for terms.
enum TermEndpoint {
  /// An endpoint for terms' collection requests.
  BASE,
}

