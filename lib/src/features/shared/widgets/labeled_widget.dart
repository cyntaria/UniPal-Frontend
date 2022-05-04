import 'package:flutter/material.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart';
import '../../../helpers/constants/app_typography.dart';

class LabeledWidget extends StatelessWidget {
  final Widget child;
  final String label;
  final SizedBox labelGap;
  final TextStyle labelStyle;
  final bool useDarkerLabel;

  const LabeledWidget({
    Key? key,
    required this.child,
    required this.label,
    this.labelGap = Insets.gapH5,
    this.useDarkerLabel = false,
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
          style: useDarkerLabel ? AppTypography.primary.body16 : labelStyle,
        ),

        labelGap,

        // Widget
        child,
      ],
    );
  }
}
