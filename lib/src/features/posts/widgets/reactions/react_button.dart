import 'package:flutter/material.dart';

// Helpers
import '../../../../helpers/constants/app_styles.dart';

class ReactButton extends AnimatedWidget {
  final AnimationController btnLongPressAnimController;
  final AnimationController btnShortPressAnimController;
  final void Function(TapDownDetails) onPressDown;
  final VoidCallback onShortTap;
  final void Function(TapUpDetails) onPressRelease;
  final bool isLongPress;
  final Widget icon;
  final Widget text;

  ReactButton({
    super.key,
    required this.btnLongPressAnimController,
    required this.btnShortPressAnimController,
    required this.onPressDown,
    required this.onShortTap,
    required this.onPressRelease,
    required this.isLongPress,
    required this.icon,
    required this.text,
  }) : super(
          listenable: Listenable.merge(
            [btnLongPressAnimController, btnShortPressAnimController],
          ),
        );

  static final _longPressScaleTween = Tween<double>(begin: 1, end: 0.85);
  static final _longPressTiltTween = Tween<double>(begin: 0, end: 0.2);
  static final _shortPressScaleTween = Tween<double>(begin: 1, end: 0.2);
  static final _shortPressTiltTween = Tween<double>(begin: 0, end: 0.8);

  double getScale() {
    if (isLongPress) {
      return _longPressScaleTween.evaluate(
        btnLongPressAnimController,
      );
    } else {
      final value = _shortPressScaleTween.evaluate(btnShortPressAnimController);
      if (value < 0.8) {
        return value >= 0.4 ? 1.6 - value : 0.8 + value;
      }
      return value;
    }
  }

  double getTilt() {
    if (isLongPress) {
      return _longPressTiltTween.evaluate(
        btnLongPressAnimController,
      );
    } else {
      final value = _shortPressTiltTween.evaluate(btnShortPressAnimController);
      if (value > 0.2) {
        return value <= 0.6 ? 0.4 - value : value - 0.8;
      } else {
        return value;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: onPressDown,
      onTapUp: onPressRelease,
      onTap: onShortTap,
      child: SizedBox(
        height: 40,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // React Icon
              Transform.scale(
                scale: getScale(),
                child: Transform.rotate(
                  angle: getTilt(),
                  child: icon,
                ),
              ),
          
              Insets.gapW10,
          
              // React Text
              Transform.scale(
                scale: getScale(),
                child: text,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
