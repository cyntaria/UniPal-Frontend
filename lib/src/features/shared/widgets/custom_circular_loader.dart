import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomCircularLoader extends StatelessWidget {
  final Color? color;

  const CustomCircularLoader({
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitRing(
        color: color ?? Colors.white,
        size: 30,
        lineWidth: 4,
        duration: const Duration(milliseconds: 1100),
      ),
    );
  }
}
