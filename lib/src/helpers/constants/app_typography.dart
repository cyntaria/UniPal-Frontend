import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io' show Platform;

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
      color: Colors.black87,
      fontSize: FontSizes.f34,
      fontWeight: FontWeight.bold,
    ),
    heading24: _outfitFont.copyWith(
      color: Colors.black87,
      fontSize: FontSizes.f24,
      fontWeight: FontWeight.bold,
    ),
    title20: _outfitFont.copyWith(
      color: Colors.black87,
      fontSize: FontSizes.f20,
      fontWeight: FontWeight.w600,
    ),
    title18: _outfitFont.copyWith(
      color: Colors.black87,
      fontSize: FontSizes.f18,
    ),
    subHeading16: _outfitFont.copyWith(
      color: Colors.black87,
      fontSize: FontSizes.f16,
    ),
    body16: _outfitFont.copyWith(
      color: Colors.black87,
      fontSize: FontSizes.f16,
      fontWeight: FontWeight.w600,
    ),
    body14: _outfitFont.copyWith(
      color: Colors.black87,
    ),
    subtitle13: _outfitFont.copyWith(
      color: Colors.black54,
      fontSize: FontSizes.f13,
    ),
    label12: _outfitFont.copyWith(
      color: Colors.black54,
      fontSize: FontSizes.f12,
    ),
    label11: _outfitFont.copyWith(
      color: Colors.black54,
      fontSize: FontSizes.f11,
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
  final TextStyle heading24;
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
    required this.heading24,
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
      heading24: textTheme.headlineSmall!,
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
      displaySmall: heading24,
      headlineLarge: heading34,
      headlineMedium: heading34,
      headlineSmall: heading24,
      titleLarge: title20,
      titleMedium: title20,
      titleSmall: title18,
      bodyLarge: body16,
      bodyMedium: body16,
      bodySmall: body14,
      subtitle1: subtitle13,
      subtitle2: subtitle13,
      labelLarge: label12,
      labelMedium: label12,
      labelSmall: label11,
    );
  }
}

/// A utility class that holds all the font sizes used throughout
/// the entire app.
///
/// This class has no constructor and all variables are `static`.
@immutable
class FontSizes {
  const FontSizes._();

  /// Font size 11
  static const f11 = 11.0;

  /// Font size 12
  static const f12 = 12.0;

  /// Font size 13
  static const f13 = 13.0;

  /// Font size 14
  static const f14 = 14.0;

  /// Font size 16
  static const f16 = 16.0;

  /// Font size 18
  static const f18 = 18.0;

  /// Font size 20
  static const f20 = 20.0;

  /// Font size 24
  static const f24 = 24.0;

  /// Font size 34
  static const f34 = 34.0;
}
