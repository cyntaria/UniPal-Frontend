import 'package:flutter/material.dart';

class CustomRefreshIndicator extends StatelessWidget {
  final Widget child;
  final RefreshCallback onRefresh;
  final double displacement, edgeOffset;
  final Color color, backgroundColor;

  const CustomRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
    this.displacement = 25.0,
    this.edgeOffset = 0.0,
    this.color = Colors.white,
    this.backgroundColor = const Color.fromARGB(255, 135, 0, 224),
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      displacement: displacement,
      edgeOffset: edgeOffset,
      color: color,
      backgroundColor: backgroundColor,
      child: child,
    );
  }
}
