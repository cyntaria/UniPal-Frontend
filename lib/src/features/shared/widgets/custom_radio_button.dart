import 'package:flutter/material.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart';
import '../../../helpers/constants/app_typography.dart';

class CustomRadioButton<T> extends StatelessWidget {
  final bool isSelected;
  final IconData icon;
  final String label;
  final double width;
  final ShapeBorder shape;
  final void Function(T) onTap;
  final T value;

  const CustomRadioButton({
    Key? key,
    this.width = 95,
    this.shape = const RoundedRectangleBorder(
      borderRadius: Corners.rounded7,
    ),
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
        child: Card(
          shape: shape,
          color: isSelected ? AppColors.primaryColor : AppColors.surfaceColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              children: [
                // Icon
                Icon(
                  icon,
                  color: isSelected ? Colors.white : AppColors.textGreyColor,
                ),

                Insets.expand,

                // Label
                Text(
                  label,
                  style: AppTypography.primary.label12.copyWith(
                    color: AppColors.textGreyColor,
                  ),
                ),

                Insets.expand,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
