import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//Helpers
import 'extensions/string_extension.dart';

/// A utility class that holds methods for validating different textFields.
/// This class has no constructor and all methods are `static`.
@immutable
class FormValidator{
  const FormValidator._();

  /// The error message for invalid email input.
  static const _invalidEmailError = 'Please enter a valid email address';

  /// The error message for empty email input.
  static const _emptyEmailInputError = 'Please enter an email';

  /// The error message for empty password input.
  static const _emptyPasswordInputError = 'Please enter a password';

  /// The error message for invalid confirm password input.
  static const _invalidConfirmPwError = "Passwords don't match";

  /// The error message for invalid current password input.
  static const _invalidCurrentPwError = 'Invalid current password!';

  /// The error message for invalid new password input.
  static const _invalidNewPwError = "Current and new password can't be same";

  /// The error message for invalid name input.
  static const _invalidNameError = 'Please enter a valid name';

  /// The error message for invalid erp input.
  static const _invalidErpError = 'Invalid erp format';

  /// The error message for empty address input.
  static const _emptyAddressInputError = 'Please enter a address';

  /// The error message for empty cinema branch input.
  static const _emptyBranchInputError = 'Please enter the branch name';

  /// The error message for invalid contact input.
  static const _invalidContactError = 'Please enter a valid contact';

  /// A method containing validation logic for email input.
  static String? emailValidator(String? email){
    if(email == null || email.isEmpty) {
      return _emptyEmailInputError;
    } else if (!email.isValidEmail) {
      return _invalidEmailError;
    }
    return null;
  }

  /// A method containing validation logic for password input.
  static String? passwordValidator(String? password) {
    if (password!.isEmpty) return _emptyPasswordInputError;
    return null;
  }

  /// A method containing validation logic for confirm password input.
  static String? confirmPasswordValidator(String? confirmPw, String inputPw) {
    if (confirmPw == inputPw.trim()) return null;
    return _invalidConfirmPwError;
  }

  /// A method containing validation logic for current password input.
  static String? currentPasswordValidator(String? inputPw, String currentPw) {
    if (inputPw == currentPw) return null;
    return _invalidCurrentPwError;
  }

  /// A method containing validation logic for new password input.
  static String? newPasswordValidator(String? newPw, String currentPw) {
    if (newPw!.isEmpty) {
      return _emptyPasswordInputError;
    }
    else if(newPw == currentPw) {
      return _invalidNewPwError;
    }
    return null;
  }

  /// A method containing validation logic for name input.
  static String? nameValidator(String? name) {
    if (name != null && name.isValidName) return null;
    return _invalidNameError;
  }

  /// A method containing validation logic for ERP input.
  static String? erpValidator(String? erp) {
    if (erp != null && erp.isValidErp) return null;
    return _invalidErpError;
  }

  /// A method containing validation logic for address input.
  static String? addressValidator(String? address) {
    if (address!.isEmpty) return _emptyAddressInputError;
    return null;
  }

  /// A method containing validation logic for contact number input.
  static String? contactValidator(String? contact) {
    if (contact != null && contact.isValidContact) return null;
    return _invalidContactError;
  }

  /// A method containing validation logic for cinema branch name input.
  static String? branchNameValidator(String? branchName) {
    if (branchName!.isEmpty) return _emptyBranchInputError;
    return null;
  }

  /// A method containing validation logic for single otp digit input.
  static String? otpDigitValidator(String? digit){
    if (digit != null && digit.isValidOtpDigit) return null;
    return '!';
  }

}
