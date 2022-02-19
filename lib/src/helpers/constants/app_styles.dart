import 'package:flutter/material.dart';

/// A utility class that holds all the icon sizes used throughout 
/// the entire app.
/// 
/// This class has no constructor and all variables are `static`.
@immutable
class IconSizes {
  const IconSizes._();

  static const double sm = 20;
  static const double med = 24;
  static const double lg = 27;
}

/// A utility class that holds all the gaps and insets used 
/// throughout the entire app by things such as padding, sizedbox etc.
/// 
/// This class has no constructor and all variables are `static`.
@immutable
class Insets {
  const Insets._();

  /// Regular insets used with [Padding]
  static const xs = 4;
  static const sm = 8;
  static const med = 12;
  static const lg = 16;
  static const xl = 32;

  /// Regular offsets used with [SizedBox]
  /// Small horizontal gap.
  static const gapSmallHt = SizedBox(height: 10);

  /// Small vertical gap.
  static const gapSmallVt = SizedBox(width: 10);

  /// Regular horizontal gap.
  static const gapRegularHt = SizedBox(height: 15);
  
  /// Regular vertical gap.
  static const gapRegularVt = SizedBox(height: 15);

  /// Medium horizontal gap.
  static const gapMediumHt = SizedBox(height: 20);
  
  /// Medium vertical gap.
  static const gapMediumVt = SizedBox(height: 20);
  
  /// Large horizontal gap.
  static const gapLargeHt = SizedBox(height: 30);
  
  /// Large vertical gap.
  static const gapLargeVt = SizedBox(height: 30);
}


/// A utility class that holds all the border radiuses used throughout 
/// the entire app by things such as container, card etc.
/// 
/// This class has no constructor and all variables are `static`.
@immutable
class Corners {
  const Corners._();

  /// Small radius value
  static const double sm = 5;

  /// Small circular radius of value [sm]
  static const Radius smRadius = Radius.circular(sm);

  /// Small border radius, rounded on all corners by [smRadius]
  static const BorderRadius smBorder = BorderRadius.all(smRadius);

  /// Medium radius value
  static const double med = 8;
  
  /// Medium circular radius of value [med]
  static const BorderRadius medBorder = BorderRadius.all(medRadius);
  
  /// Medium border radius, rounded on all corners by [medBorder]
  static const Radius medRadius = Radius.circular(med);
  
  /// Large radius value
  static const double lg = 12;
  
  /// Large circular radius of value [lg]
  static const BorderRadius lgBorder = BorderRadius.all(lgRadius);
  
  /// Large border radius, rounded on all corners by [lgRadius]
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
