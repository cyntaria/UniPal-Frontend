import 'package:flutter/material.dart';

/// A utility class that holds constants for colors used values 
/// throughout the entire app.
/// This class has no constructor and all variables are `static`.
@immutable
class AppColors {
  const AppColors._();

  /// The main orange-red color used for theming the app.
  static const Color primaryColor = Color(0xFFf03400);

  /// The color value for red color in the app.
  static const Color redColor = Color(0xFFed0000);

  /// The color value for orange color in the app.
  static const Color orangeColor = Color(0xFFf04f00);

  /// The color value for rating stars in the app.
  static const Color starsColor = Color(0xFFf78040);

  /// The color value for dark grey skeleton containers in the app.
  static const Color darkSkeletonColor = Color(0xFF656565);

  /// The color value for light grey skeleton containers in the app.
  static const Color lightSkeletonColor = Colors.grey;

  /// The red [LinearGradient] for buttons in the app.
  static const Gradient buttonGradientRed = LinearGradient(
    colors: [primaryColor, redColor],
  );

  /// The orange [LinearGradient] for buttons in the app.
  static const Gradient buttonGradientOrange = LinearGradient(
    colors: [orangeColor, redColor],
  );

  /// The orange [LinearGradient] for disabled buttons in the app.
  static const Gradient buttonGradientGrey = LinearGradient(
    colors: [textGreyColor, scaffoldGreyColor],
  );

  /// The white [LinearGradient] for fading movies carousel in the app.
  static const Gradient movieCarouselGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    stops: [0.3, 0.6, 1],
    colors: [
      Color.fromRGBO(255, 255, 255, 0.95),
      Colors.white70,
      Colors.transparent,
    ],
  );

  /// The black [LinearGradient] used to overlay movie backgrounds in the app.
  static const Gradient blackOverlayGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.2, 0.5, 0.7, 1],
    colors: [
      Color.fromRGBO(0, 0, 0, 0.6),
      Color.fromRGBO(0, 0, 0, 0.45),
      Color.fromRGBO(0, 0, 0, 0.3),
      Colors.transparent,
    ],
  );

  /// The color value for dark grey buttons in the app.
  static const Color buttonGreyColor = Color(0xFF1c1c1c);

  /// The color value for dark grey scaffold in the app.
  static const Color scaffoldColor = Color(0xFF141414);

  /// The color value for light grey scaffold in the app.
  static const Color scaffoldGreyColor = Color(0xFF2b2b2b);

  /// The color value for light grey text in the app.
  static const Color textGreyColor = Color(0xFF949494);

  /// The color value for white text in the app.
  static const Color textWhite80Color = Color(0xFFf2f2f2);

  /// The color value for dark grey [CustomDialog] in the app.
  static const Color barrierColor = Colors.black87;

  /// The color value for light grey [CustomDialog] in the app.
  static const Color barrierColorLight = Color(0xBF000000);
}
