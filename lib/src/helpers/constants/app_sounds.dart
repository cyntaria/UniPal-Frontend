import 'package:flutter/foundation.dart';

/// A utility class that holds constants for sound asset paths.
/// This class has no constructor and all variables are `static`.
@immutable
class AppSounds {
  const AppSounds._();

  /// The path for reaction box open sound asset
  static const String reactionBoxOpened = 'assets/sounds/reaction_box_open.mp3';

  /// The path for reaction box closed sound asset
  static const String reactionBoxClosed = 'assets/sounds/reaction_box_closed.mp3';

  /// The path for reaction button short tap sound asset
  static const String reactionButtonTap = 'assets/sounds/reaction_button_short_tap.mp3';

  /// The path for the reaction hover sound asset
  static const String reactionHover = 'assets/sounds/reaction_hover.mp3';

  /// The path for the reaction choose sound asset
  static const String reactionChoose = 'assets/sounds/reaction_choose.mp3';
}
