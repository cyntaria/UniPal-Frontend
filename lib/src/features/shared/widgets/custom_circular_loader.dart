import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_utils.dart';

class CustomCircularLoader extends StatelessWidget {
  final Color color;
  final double size;
  final double lineWidth;

  const CustomCircularLoader({
    super.key,
    this.color = AppColors.primaryColor,
    this.size = 30,
    this.lineWidth = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitRing(
        color: color,
        size: size,
        lineWidth: lineWidth,
        duration: Durations.slower,
      ),
    );
  }
}
