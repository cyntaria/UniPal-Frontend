import 'package:flutter/material.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_typography.dart';

class CustomFilterChip<T> extends StatefulWidget {
  final bool isSelected;
  final bool Function(bool, T value)? onChanged;
  final Widget label;
  final T value;
  final Color labelColor;
  final Color selectedLabelColor;
  final Color backgroundColor;
  final Color selectedColor;

  const CustomFilterChip({
    Key? key,
    this.labelColor = AppColors.textBlackColor,
    this.selectedLabelColor = AppColors.textWhite80Color,
    this.backgroundColor = AppColors.surfaceColor,
    this.selectedColor = AppColors.primaryColor,
    this.isSelected = false,
    this.onChanged,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  State<CustomFilterChip> createState() => _CustomFilterChipState<T>();
}

class _CustomFilterChipState<T> extends State<CustomFilterChip<T>> {
  bool _isSelected = false;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: widget.label,
      pressElevation: 0,
      labelPadding: const EdgeInsets.symmetric(horizontal: 11),
      showCheckmark: false,
      labelStyle: AppTypography.primary.subtitle13.copyWith(
        color: _isSelected ? widget.selectedLabelColor : widget.labelColor,
      ),
      backgroundColor: widget.backgroundColor,
      selectedColor: widget.selectedColor,
      selected: _isSelected,
      onSelected: (selected) {
        final allowChange = widget.onChanged?.call(selected, widget.value);
        if (allowChange != null && allowChange) {
          setState(() {
            _isSelected = selected;
          });
        }
      },
    );
  }
}
