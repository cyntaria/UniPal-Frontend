import 'package:flutter/material.dart';

class AnimatedReaction extends StatelessWidget {
  final AnimationController boxFloatController;
  final AnimationController iconChosenController;
  final AnimationController iconDragInsideController;
  final AnimationController iconDragOutsideController;
  final Interval floatInInterval;
  final Interval floatOutInterval;
  final bool isDragging;
  final bool isDraggingOutside;
  final bool isDraggingInside;
  final bool isCurrentlyHovered;
  final bool isPreviouslyHovered;
  final Widget reactionAsset;
  final String reactionLabel;
  final Animation<double> _iconMoveUpAnim;
  final Animation<double> _iconScaleAnim;

  AnimatedReaction({
    Key? key,
    required this.boxFloatController,
    required this.iconChosenController,
    required this.iconDragInsideController,
    required this.iconDragOutsideController,
    required this.isDragging,
    required this.isDraggingOutside,
    required this.isDraggingInside,
    required this.isCurrentlyHovered,
    required this.isPreviouslyHovered,
    required this.floatInInterval,
    required this.floatOutInterval,
    required this.reactionAsset,
    required this.reactionLabel,
  })  : _iconMoveUpAnim = _iconMoveUpTween.animate(
          CurvedAnimation(
            parent: boxFloatController,
            curve: floatInInterval,
            reverseCurve: floatOutInterval,
          ),
        ),
        _iconScaleAnim = _iconScaleTween.animate(
          CurvedAnimation(
            parent: boxFloatController,
            curve: floatInInterval,
            reverseCurve: floatOutInterval,
          ),
        ),
        super(key: key);

  static final _iconMoveUpTween = Tween<double>(begin: 8, end: 0);
  static final _iconScaleTween = Tween<double>(begin: 0, end: 1);
  static final _iconZoomInTween = Tween<double>(begin: 1, end: 1.8);
  static final _iconZoomOutTween = Tween<double>(begin: 1, end: 0.8);
  static final _iconDragOutsideZoomTween = Tween<double>(begin: 0.8, end: 1);
  static final _iconDragInsideZoomTween = Tween<double>(begin: 1, end: 0.8);

  double getScale() {
    if (isDragging) {
      if (isCurrentlyHovered) {
        return _iconZoomInTween.evaluate(iconChosenController);
      } else if (isPreviouslyHovered) {
        return _iconZoomOutTween.evaluate(iconChosenController);
      } else if (isDraggingInside) {
        return _iconDragInsideZoomTween.evaluate(
          iconDragInsideController,
        );
      } else {
        return 0.8;
      }
    } else if (isDraggingOutside) {
      return _iconDragOutsideZoomTween.evaluate(
        iconDragOutsideController,
      );
    } else {
      return _iconScaleAnim.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: boxFloatController,
      builder: (_, child) {
        return Transform.scale(
          scale: getScale(),
          child: Transform.translate(
            offset: Offset(
              0,
              isCurrentlyHovered ? -20 : _iconMoveUpAnim.value,
            ),
            child: child,
          ),
        );
      },
      child: Column(
        children: <Widget>[
          // Reaction Label
          if (isCurrentlyHovered)
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 2,
                horizontal: 7,
              ),
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black.withOpacity(0.3),
              ),
              child: Text(
                reactionLabel,
                style: const TextStyle(
                  fontSize: 8,
                  color: Colors.white,
                ),
              ),
            ),

          // Reaction Asset
          reactionAsset,
        ],
      ),
    );
  }
}
