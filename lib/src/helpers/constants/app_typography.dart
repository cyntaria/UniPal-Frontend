import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io' show Platform;

import 'app_colors.dart';

/// A utility class that holds all the core [TextStyle] used
/// throughout the entire app.
/// This class has no constructor and all variables are `static`.
///
/// Only create the high level variants here. Any modification can
/// be done on the fly using `style.copyWith()`.
/// `newStyle = AppTypography.primary.body1.copyWith(color: Colors.red)`.
@immutable
class AppTypography {
  const AppTypography._();

  /// Base TextTheme for the Poppins Font.
  static final _poppinsTextTheme = GoogleFonts.poppinsTextTheme();

  /// Base TextTheme for the Outfit Font.
  static final _outfitFont = GoogleFonts.outfit();

  /// The main [_FontStyle] used for most of typography in the app.
  static final primary = _FontStyle(
    fontFamily: _outfitFont.fontFamily,
    heading34: _outfitFont.copyWith(
      color: AppColors.textBlackColor,
      fontSize: 34,
      fontWeight: FontWeight.bold,
    ),
    heading22: _outfitFont.copyWith(
      color: AppColors.textBlackColor,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
    title20: _outfitFont.copyWith(
      color: AppColors.textBlackColor,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    title18: _outfitFont.copyWith(
      color: AppColors.textBlackColor,
      fontSize: 18,
    ),
    subHeading16: _outfitFont.copyWith(
      color: AppColors.textBlackColor,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    body16: _outfitFont.copyWith(
      color: AppColors.textBlackColor,
      fontSize: 16,
    ),
    body14: _outfitFont.copyWith(
      color: AppColors.textBlackColor,
      fontSize: 14,
    ),
    subtitle13: _outfitFont.copyWith(
      color: AppColors.textBlackColor,
      fontSize: 13,
    ),
    label12: _outfitFont.copyWith(
      color: AppColors.textBlackColor,
      fontSize: 12,
    ),
    label11: _outfitFont.copyWith(
      color: AppColors.textBlackColor,
      fontSize: 11,
    ),
  );

  /// The secondary [_FontStyle] used for lower level typography in the app.
  static final secondary = _FontStyle.fromTextTheme(_poppinsTextTheme);
}

/// A class containing all the variations of a [TextTheme], that are
/// commonly used throughout the app. It is used to map common typography
/// [TextStyle] names to more readable and understable names.
///
/// This allows non-designer programmers to be comfortable with the [TextTheme]
@immutable
class _FontStyle {
  final String? fontFamily;
  final TextStyle heading34;
  final TextStyle heading22;
  final TextStyle title20;
  final TextStyle title18;
  final TextStyle subHeading16;
  final TextStyle body16;
  final TextStyle body14;
  final TextStyle subtitle13;
  final TextStyle label12;
  final TextStyle label11;

  const _FontStyle({
    required this.fontFamily,
    required this.heading34,
    required this.heading22,
    required this.title20,
    required this.title18,
    required this.subHeading16,
    required this.body16,
    required this.body14,
    required this.subtitle13,
    required this.label12,
    required this.label11,
  });

  factory _FontStyle.fromTextTheme(TextTheme textTheme) {
    return _FontStyle(
      fontFamily: textTheme.bodyLarge!.fontFamily,
      heading34: textTheme.headlineLarge!,
      heading22: textTheme.headlineSmall!,
      title20: textTheme.titleLarge!,
      title18: textTheme.titleSmall!,
      subHeading16: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w400),
      body16: textTheme.bodyLarge!,
      body14: textTheme.bodyMedium!,
      subtitle13: textTheme.bodySmall!,
      label12: textTheme.labelLarge!,
      label11: textTheme.labelSmall!,
    );
  }

  TextTheme get textTheme {
    late final typography = Typography.material2018(
      platform: Platform.isIOS ? TargetPlatform.iOS : TargetPlatform.android,
    );
    return typography.white.copyWith(
      displayLarge: heading34,
      displayMedium: heading34,
      displaySmall: heading22,
      headlineLarge: heading34,
      headlineMedium: heading22,
      headlineSmall: title20,
      titleLarge: title18,
      titleMedium: subtitle13,
      titleSmall: subtitle13,
      bodyLarge: body16,
      bodyMedium: body16,
      bodySmall: body14,
      labelLarge: label12,
      labelMedium: label12,
      labelSmall: label11,
    );
  }
}
