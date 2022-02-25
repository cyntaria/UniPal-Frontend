// ignore_for_file: unnecessary_this

// Helpers
import '../constants/app_utils.dart' as AppUtils show Regexes;

/// A utility with extensions for strings.
extension StringExt on String {
  /// An extension for validating String is an email.
  bool get isValidEmail => AppUtils.Regexes.emailRegex.hasMatch(this);

  /// An extension for validating String is a full name.
  bool get isValidFullName => AppUtils.Regexes.fullNameRegex.hasMatch(this);

  /// An extension for validating String is a contact.
  bool get isValidContact => AppUtils.Regexes.contactRegex.hasMatch(this);

  /// An extension for validating String is a zipcode.
  bool get isValidZipCode => AppUtils.Regexes.zipCodeRegex.hasMatch(this);

  /// An extension for validating String is a credit card number.
  bool get isValidCreditCardNumber =>
      AppUtils.Regexes.creditCardNumberRegex.hasMatch(this);

  /// An extension for validating String is a credit card CVV.
  bool get isValidCreditCardCVV =>
      AppUtils.Regexes.creditCardCVVRegex.hasMatch(this);

  /// An extension for validating String is a credit card expiry.
  bool get isValidCreditCardExpiry =>
      AppUtils.Regexes.creditCardExpiryRegex.hasMatch(this);

  /// An extension for validating String is a valid OTP digit
  bool get isValidOtpDigit => AppUtils.Regexes.otpDigitRegex.hasMatch(this);

  /// An extension for converting String to Capitalcase.
  String get capitalize =>
      this[0].toUpperCase() + this.substring(1).toLowerCase();

  /// An extension for replacing underscores in a String with spaces.
  String get removeUnderScore => this.replaceAll('_', ' ');
}
