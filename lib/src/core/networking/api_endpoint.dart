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
  static String users(StudentEndpoint endpoint, {int? erp, int? extendedResourceId}) {
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

  /// Returns the path for a movie [endpoint].
  ///
  /// Specify movie [id] for any endpoints involving a specific movie.
  static String movies(MovieEndpoint endpoint, {int? id}) {
    var path = '/movies';
    switch (endpoint) {
      case MovieEndpoint.BASE: return path;
      case MovieEndpoint.BY_ID: {
        assert(id != null, 'movieId is required for BY_ID endpoint');
        return '$path/id/$id';
      }
      case MovieEndpoint.ROLES: {
        assert(id != null, 'movieId is required for ROLES endpoint');
        return '$path/id/$id/roles';
      }
    }
  }

  /// Returns the path for a role [endpoint].
  ///
  /// Specify role [id] for any endpoints involving a specific role.
  static String roles(RoleEndpoint endpoint, {int? id}) {
    var path = '/roles';
    switch (endpoint) {
      case RoleEndpoint.BASE: return path;
      case RoleEndpoint.BY_ID: {
        assert(id != null, 'roleId is required for BY_ID endpoint');
        return '$path/id/$id';
      }
      case RoleEndpoint.MOVIES: {
        assert(id != null, 'roleId is required for MOVIES endpoint');
        return '$path/id/$id/movies';
      }
    }
  }

  /// Returns the path for a show [endpoint].
  ///
  /// Specify show [id] for any endpoints involving an individual show.
  static String shows(ShowEndpoint endpoint, {int? id}) {
    var path = '/shows';
    switch(endpoint){
      case ShowEndpoint.BASE: return path;
      case ShowEndpoint.FILTERS: return '$path/filters';
      case ShowEndpoint.BY_ID: {
        assert(id != null, 'showId is required for BY_ID endpoint');
        return '$path/id/$id';
      }
    }
  }

  /// Returns the path for a theater [endpoint].
  ///
  /// Specify theater [id] for any endpoints involving an individual theater.
  static String theaters(TheaterEndpoint endpoint, {int? id}) {
    var path = '/theaters';
    switch(endpoint){
      case TheaterEndpoint.BASE: return path;
      case TheaterEndpoint.BY_ID: {
        assert(id != null, 'theaterId is required for BY_ID endpoint');
        return '$path/id/$id';
      }
    }
  }

  /// Returns the path for a booking [endpoint].
  ///
  /// Specify booking [id] for any endpoints involving an individual booking.
  static String bookings(BookingEndpoint endpoint, {int? id}) {
    var path = '/bookings';
    switch(endpoint){
      case BookingEndpoint.BASE: return path;
      case BookingEndpoint.FILTERS: return '$path/filters';
      case BookingEndpoint.USERS: {
        assert(id != null, 'bookingId is required for USERS endpoint');
        return '$path/users/$id';
      }
      case BookingEndpoint.SHOWS: {
        assert(id != null, 'bookingId is required for SHOWS endpoint');
        return '$path/shows/$id';
      }
      case BookingEndpoint.BY_ID: {
        assert(id != null, 'bookingId is required for BY_ID endpoint');
        return '$path/id/$id';
      }
    }
  }

  /// Returns the path for a payment [endpoint].
  ///
  /// Specify payment [id] for any endpoints involving an individual payment.
  static String payments(PaymentEndpoint endpoint, {int? id}) {
    var path = '/payments';
    switch(endpoint){
      case PaymentEndpoint.BASE: return path;
      case PaymentEndpoint.USERS: {
        assert(id != null, 'paymentId is required for USERS endpoint');
        return '$path/users/$id';
      }
      case PaymentEndpoint.BY_ID: {
        assert(id != null, 'paymentId is required for BY_ID endpoint');
        return '$path/id/$id';
      }
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

/// A collection of endpoints used for movies.
enum MovieEndpoint {
  /// An endpoint for movies' collection requests.
  BASE,

  /// An endpoint for individual movie requests.
  BY_ID,

  /// An endpoint for individual movie's roles.
  ROLES
}

/// A collection of endpoints used for roles.
enum RoleEndpoint {
  /// An endpoint for roles' collection requests.
  BASE,

  /// An endpoint for individual role requests.
  BY_ID,

  /// An endpoint for individual role's movies.
  MOVIES
}

/// A collection of endpoints used for shows.
enum ShowEndpoint {
  /// An endpoint for shows' collection requests.
  BASE,

  /// An endpoint for individual show requests.
  BY_ID,

  /// An endpoint for custom show requests with query parameters.
  FILTERS
}

/// A collection of endpoints used for theaters.
enum TheaterEndpoint {
  /// An endpoint for theaters' collection requests.
  BASE,

  /// An endpoint for individual theater requests.
  BY_ID
}

/// A collection of endpoints used for bookings.
enum BookingEndpoint {
  /// An endpoint for bookings' collection requests.
  BASE,

  /// An endpoint for individual booking requests.
  BY_ID,

  /// An endpoint for individual user bookings' requests.
  USERS,

  /// An endpoint for individual show bookings' requests.
  SHOWS,

  /// An endpoint for custom booking requests with query parameters.
  FILTERS
}

/// A collection of endpoints used for payments.
enum PaymentEndpoint {
  /// An endpoint for roles collection requests.
  BASE,

  /// An endpoint for individual role requests.
  BY_ID,

  /// An endpoint for an individual user's payments' requests.
  USERS
}
