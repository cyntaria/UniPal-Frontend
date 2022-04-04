import 'package:flutter/material.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart';
import '../../../helpers/constants/app_typography.dart';
import '../../../helpers/constants/app_utils.dart';

class CustomRadioButton<T> extends StatelessWidget {
  final bool isSelected;
  final IconData icon;
  final String label;
  final double width;
  final double height;
  final BorderRadiusGeometry borderRadius;
  final void Function(T) onTap;
  final T value;

  const CustomRadioButton({
    Key? key,
    this.width = 106,
    this.height = 47,
    this.borderRadius = Corners.rounded7,
    required this.value,
    required this.isSelected,
    required this.onTap,
    required this.icon,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap.call(value),
      child: SizedBox(
        width: width,
        height: height,
        child: AnimatedContainer(
          curve: Curves.ease,
          duration: Durations.medium,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            gradient: isSelected ? AppColors.buttonGradientPurple : null,
            color: AppColors.surfaceColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon
                Icon(
                  icon,
                  color: isSelected ? Colors.white : AppColors.textGreyColor,
                ),

                Insets.gapW3,

                // Label
                Text(
                  label,
                  style: AppTypography.primary.body14.copyWith(
                    color: isSelected ? Colors.white : AppColors.textGreyColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
