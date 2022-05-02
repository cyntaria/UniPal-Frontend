import 'package:flutter/material.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart';

class LabeledWidget extends StatelessWidget {
  final Widget child;
  final String label;
  final SizedBox labelGap;
  final TextStyle labelStyle;

  const LabeledWidget({
    Key? key,
    required this.child,
    required this.label,
    this.labelGap = Insets.gapH5,
    this.labelStyle = const TextStyle(
      fontSize: 14,
      color: AppColors.textLightGreyColor,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          label,
          style: labelStyle,
        ),

        labelGap,

        // Widget
        child,
      ],
    );
  }
}
