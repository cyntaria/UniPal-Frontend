import 'package:flutter/material.dart';

// Constants
import '../../helpers/constants/app_colors.dart';

/// A utility class that holds themes for the app.
/// This class has no constructor and all methods are `static`.
@immutable
class CustomTheme {
  const CustomTheme._();

  /// The main starting theme for the app.
  ///
  /// Sets the following defaults:
  /// * primaryColor: [AppColors.primaryColor],
  /// * scaffoldBackgroundColor: [AppColors.scaffoldColor],
  /// * fontFamily: [AppColors.poppinsFont].fontFamily,
  /// * iconTheme: [Colors.white] for default icon
  /// * textButtonTheme: [TextButtonTheme] without the default padding,
  static late final mainTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: AppColors.primaryColor,
      secondary: AppColors.primaryColor,
    ),
    scaffoldBackgroundColor: AppColors.scaffoldColor,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
  );
}
