import 'dart:math';

import 'package:flutter/material.dart';

// Helpers
import '../extensions/datetime_extension.dart';
import 'app_colors.dart';

/// A utility class that holds commonly used functions
/// This class has no constructor and all variables are `static`.
@immutable
class AppUtils {
  const AppUtils._();

  static Random randomizer([int? seed]) => Random(seed);

  /// A utility method to map an integer to a color code
  /// Useful for color coding class erps
  static Color getRandomColor([int? seed]) {
    final rInt = seed != null ? (seed + DateTime.now().minute) : null;
    return AppColors.primaries[randomizer(rInt).nextInt(
      AppColors.primaries.length,
    )];
  }

  /// A utility method to convert 0/1 to false/true
  static bool boolFromInt(int i) => i == 1;

  /// A utility method to convert true/false to 1/0
  // ignore: avoid_positional_boolean_parameters
  static int boolToInt(bool b) => b ? 1 : 0;

  /// A utility method to convert DateTime to API
  /// accepted JSON format
  static String dateToJson(DateTime date) {
    return date.toDateString('yyyy-MM-dd');
  }

  /// A utility method to convert any instance to null
  static T? toNull<T>(Object? _) => null;
}

/// A utility class that holds commonly used regular expressions
/// employed throughout the entire app.
/// This class has no constructor and all variables are `static`.
@immutable
class Regexes {
  const Regexes._();

  /// The regular expression for validating emails in the app.
  static RegExp emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\.]+\.(com|pk)+",
  );

  /// The regular expression for validating contacts in the app.
  static RegExp contactRegex = RegExp(r'^(03|3)\d{9}$');

  /// The regular expression for validating erps in the app.
  static RegExp erpRegex = RegExp(r'^[1-9]{1}\d{4}$');

  /// The regular expression for validating names in the app.
  static RegExp nameRegex = RegExp(r'^[a-z A-Z]+$');

  /// The regular expression for validating zip codes in the app.
  static RegExp zipCodeRegex = RegExp(r'^\d{5}$');

  /// The regular expression for validating credit card numbers in the app.
  static RegExp creditCardNumberRegex =
      RegExp(r'^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14})$');

  /// The regular expression for validating credit card CVV in the app.
  static RegExp creditCardCVVRegex = RegExp(r'^[0-9]{3}$');

  /// The regular expression for validating credit card expiry in the app.
  static RegExp creditCardExpiryRegex =
      RegExp(r'(0[1-9]|10|11|12)/20[0-9]{2}$');

  /// The regular expression for validating credit card expiry in the app.
  static final RegExp otpDigitRegex = RegExp(r'^[0-9]{1}$');
}

/// A utility class that holds all the timings used throughout
/// the entire app by things such as animations, tickers etc.
///
/// This class has no constructor and all variables are `static`.
@immutable
class Durations {
  const Durations._();

  static const fastest = Duration(milliseconds: 150);
  static const fast = Duration(milliseconds: 250);
  static const medium = Duration(milliseconds: 300);
  static const slow = Duration(milliseconds: 700);
  static const slower = Duration(milliseconds: 1000);
}
