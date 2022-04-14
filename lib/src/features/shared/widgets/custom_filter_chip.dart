import 'package:flutter/material.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_typography.dart';

class CustomFilterChip<T> extends StatefulWidget {
  final bool isSelected;
  final bool Function(bool, T value) onChanged;
  final Widget label;
  final T value;
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
    this.side = const BorderSide(
      color: Color.fromARGB(255, 207, 207, 207),
      width: 1.2,
    ),
    required this.isSelected,
    required this.onChanged,
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
      showCheckmark: false,
      labelStyle: AppTypography.primary.subtitle13.copyWith(
        color: _isSelected ? widget.selectedLabelColor : widget.labelColor,
      ),
      side: !_isSelected
          ? widget.side
          : widget.side.copyWith(
              color: widget.selectedColor,
            ),
      backgroundColor: widget.backgroundColor,
      selectedColor: widget.selectedColor,
      selected: _isSelected,
      onSelected: (selected) {
        final allowChange = widget.onChanged(selected, widget.value);
        if (allowChange) {
          setState(() {
            _isSelected = selected;
          });
        }
      },
    );
  }
}
