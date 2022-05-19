import 'package:flutter/material.dart';

import '../../../../helpers/constants/app_styles.dart';

class FloatingWhiteBox extends StatelessWidget {
  final AnimationController controller;
  final Animation<double> _fadeAnim;

  FloatingWhiteBox({
    super.key,
    required this.controller,
  })  : _fadeAnim = _opacityTween.animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.5, 0.9),
          ),
        );

  static final _opacityTween = Tween<double>(begin: 0, end: 1);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnim,
      child: Container(
        width: 300,
        margin: const EdgeInsets.only(left: 10),
        height: 45,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey.shade300, width: 0.3),
          boxShadow: Shadows.small,
        ),
      ),
    );
  }
}
