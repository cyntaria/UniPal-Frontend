import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    headingLarge: _outfitFont.copyWith(
      color: Colors.black87,
      fontSize: FontSizes.f34,
      fontWeight: FontWeight.bold,
    ),
    headingSmall: _outfitFont.copyWith(
      color: Colors.black87,
      fontSize: FontSizes.f24,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: _outfitFont.copyWith(
      color: Colors.black87,
      fontSize: FontSizes.f20,
      fontWeight: FontWeight.w600,
    ),
    titleSmall: _outfitFont.copyWith(
      color: Colors.black87,
      fontSize: FontSizes.f18,
    ),
    subHeading: _outfitFont.copyWith(
      color: Colors.black87,
      fontSize: FontSizes.f16,
    ),
    bodyLarge: _outfitFont.copyWith(
      color: Colors.black87,
      fontSize: FontSizes.f16,
      fontWeight: FontWeight.w600,
    ),
    bodySmall: _outfitFont.copyWith(
      color: Colors.black87,
    ),
    subtitle: _outfitFont.copyWith(
      color: Colors.black54,
      fontSize: FontSizes.f13,
    ),
    labelLarge: _outfitFont.copyWith(
      color: Colors.black54,
      fontSize: FontSizes.f12,
    ),
    labelSmall: _outfitFont.copyWith(
      color: Colors.black54,
      fontSize: FontSizes.f11,
    ),
  );

  /// The secondary [_FontStyle] used for lower level typography in the app.
  static final secondary = _FontStyle.fromTextTheme(_poppinsTextTheme);
}

/// A class containing all the variations of a [TextTheme], that are
/// commonly used throughout the app.
@immutable
class _FontStyle {
  final TextStyle headingLarge;
  final TextStyle headingSmall;
  final TextStyle titleLarge;
  final TextStyle titleSmall;
  final TextStyle subHeading;
  final TextStyle bodyLarge;
  final TextStyle bodySmall;
  final TextStyle subtitle;
  final TextStyle labelLarge;
  final TextStyle labelSmall;

  const _FontStyle({
    required this.headingLarge,
    required this.headingSmall,
    required this.titleLarge,
    required this.titleSmall,
    required this.subHeading,
    required this.bodyLarge,
    required this.bodySmall,
    required this.subtitle,
    required this.labelLarge,
    required this.labelSmall,
  });

  factory _FontStyle.fromTextTheme(TextTheme textTheme) {
    return _FontStyle(
      headingLarge: textTheme.headlineLarge!,
      headingSmall: textTheme.headlineSmall!,
      titleLarge: textTheme.titleLarge!,
      titleSmall: textTheme.titleSmall!,
      subHeading: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w400),
      bodyLarge: textTheme.bodyLarge!,
      bodySmall: textTheme.bodyMedium!,
      labelLarge: textTheme.labelLarge!,
      labelSmall: textTheme.labelSmall!,
      subtitle: textTheme.bodySmall!,
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
