import 'package:flutter/material.dart';

/// A utility class that holds all the icon sizes used throughout 
/// the entire app.
/// 
/// This class has no constructor and all variables are `static`.
@immutable
class IconSizes {
  const IconSizes._();

  static const double scale = 1;
  static const double med = 24;
}

/// A utility class that holds all the gaps and insets used 
/// throughout the entire app by things such as padding, sizedbox etc.
/// 
/// This class has no constructor and all variables are `static`.
@immutable
class Insets {
  const Insets._();

  static double scale = 1;
  static double offsetScale = 1;

  // Regular paddings
  static double get xs => 4 * scale;
  static double get sm => 8 * scale;
  static double get med => 12 * scale;
  static double get lg => 16 * scale;
  static double get xl => 32 * scale;

  // Offset, used for the edge of the window, or to separate large sections in the app
  static double get offset => 40 * offsetScale;
}

/// A utility class that holds all the border radiuses used throughout 
/// the entire app by things such as container, card etc.
/// 
/// This class has no constructor and all variables are `static`.
@immutable
class Corners {
  const Corners._();

  static const double sm = 3;
  static const BorderRadius smBorder = BorderRadius.all(smRadius);
  static const Radius smRadius = Radius.circular(sm);

  static const double med = 5;
  static const BorderRadius medBorder = BorderRadius.all(medRadius);
  static const Radius medRadius = Radius.circular(med);

  static const double lg = 8;
  static const BorderRadius lgBorder = BorderRadius.all(lgRadius);
  static const Radius lgRadius = Radius.circular(lg);
}

/// A utility class that holds all the shadows used throughout 
/// the entire app by things such as animations, tickers etc.
/// 
/// This class has no constructor and all variables are `static`.
@immutable
class Shadows {
  const Shadows._();

  static const List<BoxShadow> universal = [
    BoxShadow(
      color: Color.fromRGBO(51, 51, 51, 0.15),
      blurRadius: 10,
    ),
  ];

  static const List<BoxShadow> small = [
    BoxShadow(
      color: Color.fromRGBO(51, 51, 51, .15),
      blurRadius: 3,
      offset: Offset(0, 1),
    ),
  ];
}
