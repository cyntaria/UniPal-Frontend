import 'package:flutter/material.dart';

class AnimatedChosedReaction extends AnimatedWidget {
  final double leftMargin;
  final Widget child;
  final Animation<double> _animation;

  AnimatedChosedReaction({
    Key? key,
    required AnimationController controller,
    required this.leftMargin,
    required this.child,
  })  : _animation = CurvedAnimation(
          parent: controller,
          curve: Curves.decelerate,
        ),
        super(key: key, listenable: controller);

  // Make the Tweens static because they don't change.
  static final _iconZoomTween = Tween<double>(begin: 1.8, end: 0);
  static final _iconMoveUpTween = Tween<double>(begin: 180, end: 0);
  static final _iconMoveLeftTween = Tween<double>(begin: 20, end: 10);

  double _processTop(double value) {
    return value >= 120 ? value - 80 : 160 - value;
  }

  @override
  Widget build(BuildContext context) {
    final _topMargin = _processTop(_iconMoveUpTween.evaluate(_animation));
    final _leftMargin = _iconMoveLeftTween.evaluate(_animation) + leftMargin;
    final _scale = _iconZoomTween.evaluate(_animation);
    return Container(
      margin: EdgeInsets.only(bottom: _topMargin, left: _leftMargin),
      child: Transform.scale(
        scale: _scale,
        child: child,
      ),
    );
  }
}
