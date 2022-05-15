import 'package:flutter/material.dart';

// Widgets
import '../../../../helpers/constants/app_styles.dart';
import 'animated_reaction.dart';
import 'floating_reaction_model.dart';

class FloatingReactionsRow extends StatelessWidget {
  final AnimationController boxFloatController;
  final Animation<double> _boxFloatRightAnim;
  final AnimationController dragOutsideController;
  final AnimationController iconChosenController;
  final AnimationController dragInsideController;
  final bool isDragging, isDraggingOutside, isDraggingInside;
  final int hoveredIconIndex, prevHoveredIconIndex;
  final List<FloatingReactionModel> reactions;
  final Widget Function(String assetPath) assetBuilder;

  FloatingReactionsRow({
    Key? key,
    required this.isDragging,
    required this.isDraggingInside,
    required this.isDraggingOutside,
    required this.boxFloatController,
    required this.dragInsideController,
    required this.dragOutsideController,
    required this.iconChosenController,
    required this.hoveredIconIndex,
    required this.prevHoveredIconIndex,
    required this.reactions,
    required this.assetBuilder,
  })  : _boxFloatRightAnim = _boxMoveRightTween.animate(
          CurvedAnimation(
            parent: boxFloatController,
            curve: const Interval(
              0,
              1,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        super(key: key);

  // Make the Tweens static because they don't change.
  static final _boxMoveRightTween = Tween<double>(begin: 0, end: 6);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _boxFloatRightAnim,
      builder: (_, child) {
        final _leftMargin = _boxMoveRightTween.evaluate(_boxFloatRightAnim);
        return Padding(
          padding: EdgeInsets.only(left: _leftMargin),
          child: child,
        );
      },
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: reactions.length,
        separatorBuilder: (_, __) => Insets.gapW5,
        itemBuilder: (_, i) => AnimatedReaction(
          boxFloatController: boxFloatController,
          iconChosenController: iconChosenController,
          iconDragInsideController: dragInsideController,
          iconDragOutsideController: dragOutsideController,
          isDragging: isDragging,
          isDraggingOutside: isDraggingOutside,
          isDraggingInside: isDraggingInside,
          isCurrentlyHovered: hoveredIconIndex == i,
          isPreviouslyHovered: prevHoveredIconIndex == i,
          floatInInterval: Interval(0 + 0.1 * i, 0.5 + 0.1 * i),
          floatOutInterval: Interval(0.5 - 0.1 * i, 1 - 0.1 * i),
          reactionAsset: assetBuilder(reactions[i].assetPath),
          reactionLabel: reactions[i].label,
        ),
      ),
    );
  }
}
