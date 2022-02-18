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

  /// Base TextTheme for the Roboto Font.
  static final _robotoTextTheme = GoogleFonts.robotoTextTheme();

  /// The main [_FontStyle] used for most of typography in the app.
  static final primary = _FontStyle.fromTextTheme(_poppinsTextTheme);

  /// The secondary [_FontStyle] used for lower level typography in the app.
  static final secondary = _FontStyle.fromTextTheme(_robotoTextTheme);
}

/// A class containing all the variations of a [TextTheme], that are
/// commonly used throughout the app.
@immutable
class _FontStyle {
  final TextStyle h1;
  final TextStyle h2;
  final TextStyle h3;
  final TextStyle title1;
  final TextStyle title2;
  final TextStyle body1;
  final TextStyle body2;
  final TextStyle body3;
  final TextStyle caption;

  const _FontStyle({
    required this.h1,
    required this.h2,
    required this.h3,
    required this.title1,
    required this.title2,
    required this.body1,
    required this.body2,
    required this.body3,
    required this.caption,
  });

  factory _FontStyle.fromTextTheme(TextTheme textTheme) {
    return _FontStyle(
      h1: textTheme.headlineLarge!,
      h2: textTheme.headlineMedium!,
      h3: textTheme.headlineSmall!,
      title1: textTheme.titleLarge!,
      title2: textTheme.titleMedium!,
      body1: textTheme.bodyLarge!,
      body2: textTheme.bodyMedium!,
      body3: textTheme.bodySmall!,
      caption: textTheme.labelSmall!,
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

  /// Provides the ability to nudge the app-wide font scale in either direction
  static const scale = 1;

  static const s10 = 10 * scale;
  static const s11 = 11 * scale;
  static const s12 = 12 * scale;
  static const s14 = 14 * scale;
  static const s16 = 16 * scale;
  static const s24 = 24 * scale;
  static const s48 = 48 * scale;
}
