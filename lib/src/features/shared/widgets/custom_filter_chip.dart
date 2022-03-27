import 'package:flutter/material.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_typography.dart';

class CustomFilterChip extends StatelessWidget {
  final bool isSelected;
  final void Function(bool) onSelected;
  final Widget label;
  final Color labelColor;
  final Color selectedLabelColor;
  final Color backgroundColor;
  final Color selectedColor;
  final BorderSide side;

  const CustomFilterChip({
    Key? key,
    this.labelColor = AppColors.textBlackColor,
    this.selectedLabelColor = AppColors.textWhite80Color,
    this.backgroundColor = AppColors.surfaceColor,
    this.selectedColor = AppColors.primaryColor,
    this.side = const BorderSide(color: AppColors.lightOutlineColor),
    required this.isSelected,
    required this.onSelected,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: label,
      labelStyle: AppTypography.primary.subtitle13.copyWith(
        color: isSelected ? selectedLabelColor : labelColor,
      ),
      side: side,
      backgroundColor: backgroundColor,
      selectedColor: selectedColor,
      selected: isSelected,
      onSelected: onSelected,
    );
  }
}
