import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';

// Helpers
// import '../../../../helpers/constants/app_sounds.dart';

// Widgets
import 'animated_chosed_reaction.dart';
import 'floating_reaction_model.dart';
import 'floating_reactions_row.dart';
import 'floating_white_box.dart';
import 'react_button.dart';

class FloatingReactionsWidget extends StatefulWidget {
  final List<FloatingReactionModel> reactions;
  final FloatingReactionModel defaultReaction;
  final int shortTapSelectIndex;
  final void Function(FloatingReactionModel currentSelected)? onSelected;
  final void Function(FloatingReactionModel? lastSelected)? onUnSelect;

  const FloatingReactionsWidget({
    super.key,
    required this.reactions,
    required this.defaultReaction,
    required this.shortTapSelectIndex,
    this.onSelected,
    this.onUnSelect,
  });

  @override
  _FloatingReactionsWidgetState createState() =>
      _FloatingReactionsWidgetState();
}

class _FloatingReactionsWidgetState extends State<FloatingReactionsWidget>
    with TickerProviderStateMixin {
  late AudioPlayer audioPlayer;

  Duration durationLongPress = const Duration(milliseconds: 250);
  Duration durationShortPress = const Duration(milliseconds: 500);
  Duration durationAnimationBox = const Duration(milliseconds: 500);
  Duration durationBtnLongPress = const Duration(milliseconds: 150);
  Duration durationIconDrag = const Duration(milliseconds: 150);
  Duration durationIconRelease = const Duration(milliseconds: 1000);

  late AnimationController btnLongPressAnimController;
  late AnimationController btnShortPressAnimController;
  late AnimationController boxFloatAnimController;
  late AnimationController iconChosenAnimController;
  late AnimationController iconDragInsideAnimController;
  late AnimationController iconDragOutsideAnimController;
  late AnimationController boxDragOutsideAnimController;
  late AnimationController iconReleaseAnimController;

  late Timer holdTimer;
  bool isLongPress = false;
  bool isDragging = false;
  bool isDraggingOutside = false;
  bool isJustDragInside = true;

  int chosenReactionIndex = -1;
  int hoveredIconIndex = -1;
  int previousHoveredIconIndex = -1;

  bool get isReactionChosen => chosenReactionIndex != -1;
  bool get isReactionHovered => hoveredIconIndex != -1;
  bool get isReactionPrevHovered => previousHoveredIconIndex != -1;

  @override
  void initState() {
    super.initState();

    audioPlayer = AudioPlayer();
    btnLongPressAnimController = AnimationController(
      vsync: this,
      duration: durationBtnLongPress,
    );
    btnShortPressAnimController = AnimationController(
      vsync: this,
      duration: durationShortPress,
    );
    boxFloatAnimController = AnimationController(
      vsync: this,
      duration: durationAnimationBox,
    );
    boxDragOutsideAnimController = AnimationController(
      vsync: this,
      duration: durationIconDrag,
    );
    iconChosenAnimController = AnimationController(
      vsync: this,
      duration: durationIconDrag,
    );
    iconDragOutsideAnimController = AnimationController(
      vsync: this,
      duration: durationIconDrag,
    );
    iconDragInsideAnimController = AnimationController(
      vsync: this,
      duration: durationIconDrag,
    );
    iconDragInsideAnimController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          isJustDragInside = false;
        });
      }
    });
    iconReleaseAnimController = AnimationController(
      vsync: this,
      duration: durationIconRelease,
    );
  }

  @override
  void dispose() {
    btnLongPressAnimController.dispose();
    btnShortPressAnimController.dispose();
    boxFloatAnimController.dispose();
    iconChosenAnimController.dispose();
    iconDragInsideAnimController.dispose();
    iconDragOutsideAnimController.dispose();
    boxDragOutsideAnimController.dispose();
    iconReleaseAnimController.dispose();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: onHorizontalDragEndBoxIcon,
      onHorizontalDragUpdate: onHorizontalDragUpdateBoxIcon,
      child: Stack(
        children: <Widget>[
          // Box and icons
          Positioned(
            top: 20,
            bottom: 0,
            left: 0,
            right: 0,
            child: Stack(
              children: <Widget>[
                // The White Box
                Positioned(
                  left: 10,
                  child: FloatingWhiteBox(
                    controller: boxFloatAnimController,
                  ),
                ),

                // Icons Inside The Box
                FloatingReactionsRow(
                  reactions: widget.reactions,
                  isDragging: isDragging,
                  isDraggingInside: isJustDragInside,
                  isDraggingOutside: isDraggingOutside,
                  boxFloatController: boxFloatAnimController,
                  dragInsideController: iconDragInsideAnimController,
                  dragOutsideController: iconDragOutsideAnimController,
                  iconChosenController: iconChosenAnimController,
                  hoveredIconIndex: hoveredIconIndex,
                  prevHoveredIconIndex: previousHoveredIconIndex,
                  assetBuilder: (assetPath) => Lottie.asset(
                    assetPath,
                    height: 40,
                    width: 40,
                  ),
                ),
              ],
            ),
          ),

          // React Button
          Positioned(
            bottom: 0,
            child: ReactButton(
              btnLongPressAnimController: btnLongPressAnimController,
              btnShortPressAnimController: btnShortPressAnimController,
              onPressDown: onPressDown,
              onPressRelease: onPressRelease,
              onShortTap: onShortTap,
              isLongPress: isLongPress,
              icon: Image.asset(
                getButtonIcon(),
                width: 19,
                height: 19,
                fit: BoxFit.contain,
                color: getButtonIconColor(),
              ),
              text: Text(
                getButtonText(),
                style: TextStyle(
                  color: getButtonColor(),
                  fontSize: 14,
                ),
              ),
            ),
          ),

          // This is the widget that pops out of the box and floats to selected
          // reaction box
          if (!isDragging &&
              isReactionChosen &&
              chosenReactionIndex != widget.shortTapSelectIndex)
            AnimatedChosedReaction(
              controller: iconReleaseAnimController,
              leftMargin: 20 + chosenReactionIndex * 48,
              child: Image.asset(
                widget.reactions[chosenReactionIndex].logoPath,
                width: 19,
                height: 19,
              ),
            ),
        ],
      ),
    );
  }

  String getButtonText() {
    if (isDragging || !isReactionChosen) {
      return widget.defaultReaction.label;
    }
    return widget.reactions[chosenReactionIndex].label;
  }

  Color getButtonColor() {
    if (isDragging || !isReactionChosen) {
      return widget.defaultReaction.color;
    }
    return widget.reactions[chosenReactionIndex].color;
  }

  String getButtonIcon() {
    if (isDragging || !isReactionChosen) {
      return widget.defaultReaction.logoPath;
    }
    return widget.reactions[chosenReactionIndex].logoPath;
  }

  Color? getButtonIconColor() {
    if (isDragging || !isReactionChosen) {
      return widget.defaultReaction.color;
    }
    return null;
  }

  void onHorizontalDragEndBoxIcon(DragEndDetails dragEndDetail) {
    onPressRelease(null);
    setState(() {
      isDragging = false;
      isDraggingOutside = false;
      isJustDragInside = true;
      previousHoveredIconIndex = -1;
      hoveredIconIndex = -1;
    });
  }

  void onHorizontalDragUpdateBoxIcon(DragUpdateDetails dragUpdateDetail) {
    // return if the drag is drag without press button
    if (!isLongPress) return;

    if (dragUpdateDetail.localPosition.dy >= -20 &&
        dragUpdateDetail.localPosition.dy <= 115) {
      setState(() {
        isDragging = true;
        isDraggingOutside = false;
      });

      if (isJustDragInside && !iconDragInsideAnimController.isAnimating) {
        iconDragInsideAnimController
          ..reset()
          ..forward();
      }

      if (dragUpdateDetail.globalPosition.dx >= 20 &&
          dragUpdateDetail.globalPosition.dx < 83) {
        if (hoveredIconIndex != 0) {
          handleWhenDragBetweenIcon(0);
        }
      } else if (dragUpdateDetail.globalPosition.dx >= 83 &&
          dragUpdateDetail.globalPosition.dx < 126) {
        if (hoveredIconIndex != 1) {
          handleWhenDragBetweenIcon(1);
        }
      } else if (dragUpdateDetail.globalPosition.dx >= 126 &&
          dragUpdateDetail.globalPosition.dx < 180) {
        if (hoveredIconIndex != 2) {
          handleWhenDragBetweenIcon(2);
        }
      } else if (dragUpdateDetail.globalPosition.dx >= 180 &&
          dragUpdateDetail.globalPosition.dx < 233) {
        if (hoveredIconIndex != 3) {
          handleWhenDragBetweenIcon(3);
        }
      } else if (dragUpdateDetail.globalPosition.dx >= 233 &&
          dragUpdateDetail.globalPosition.dx < 286) {
        if (hoveredIconIndex != 4) {
          handleWhenDragBetweenIcon(4);
        }
      } else if (dragUpdateDetail.globalPosition.dx >= 286 &&
          dragUpdateDetail.globalPosition.dx < 340) {
        if (hoveredIconIndex != 5) {
          handleWhenDragBetweenIcon(5);
        }
      }
    } else {
      previousHoveredIconIndex = -1;
      hoveredIconIndex = -1;
      isJustDragInside = true;

      if (isDragging && !isDraggingOutside) {
        isDragging = false;
        isDraggingOutside = true;
        iconDragOutsideAnimController
          ..reset()
          ..forward();
        boxDragOutsideAnimController
          ..reset()
          ..forward();
      }
      setState(() {});
    }
  }

  void handleWhenDragBetweenIcon(int currentIcon) {
    // playSound(AppSounds.reactionHover);
    previousHoveredIconIndex = hoveredIconIndex;
    hoveredIconIndex = currentIcon;
    setState(() {});
    iconChosenAnimController
      ..reset()
      ..forward();
  }

  void onPressDown(TapDownDetails _) {
    holdTimer = Timer(durationBtnLongPress, () {
      // playSound(AppSounds.reactionBoxOpened);
      isLongPress = true;
      btnLongPressAnimController.forward();
      boxFloatAnimController.forward();
    });
    setState(() {});
  }

  void onPressRelease(TapUpDetails? _) {
    if (isLongPress) {
      if (!isReactionHovered) {
        // playSound(AppSounds.reactionBoxClosed);
        if (!isReactionChosen) {
          // if nothing was selected previously
          widget.onUnSelect?.call(null);
        } else {
          widget.onUnSelect?.call(widget.reactions[chosenReactionIndex]);
          setState(() {
            chosenReactionIndex = -1;
          });
        }
      } else {
        widget.onSelected?.call(widget.reactions[hoveredIconIndex]);
        // playSound(AppSounds.reactionChoose);
        setState(() {
          chosenReactionIndex = hoveredIconIndex;
        });
      }
    }

    Timer(durationAnimationBox, () {
      setState(() {
        isLongPress = false;
      });
    });

    holdTimer.cancel();

    btnLongPressAnimController.reverse();
    boxFloatAnimController.reverse();

    iconReleaseAnimController
      ..reset()
      ..forward();
  }

  void onShortTap() {
    if (!isLongPress) {
      if (!isReactionChosen) {
        // if no prev selected
        chosenReactionIndex = widget.shortTapSelectIndex;
        // playSound(AppSounds.reactionButtonTap);
        widget.onSelected?.call(widget.reactions[widget.shortTapSelectIndex]);
        btnShortPressAnimController.forward();
      } else {
        // if prev selected
        widget.onUnSelect?.call(widget.reactions[chosenReactionIndex]);
        chosenReactionIndex = -1;
        btnShortPressAnimController.reverse();
      }
      setState(() {});
    }
  }

  Future<void> playSound(String soundName) async {
    // Sometimes multiple sound will play the same time, so we'll stop all before play the newest
    await audioPlayer.stop();
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/$soundName');
    final audioAsset = await rootBundle.load(soundName);
    final audioBytes = audioAsset.buffer.asUint8List();
    await file.writeAsBytes(audioBytes);
    await audioPlayer.play(file.path, isLocal: true);
  }
}
