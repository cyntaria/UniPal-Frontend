import 'package:flutter/material.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart';

class DropdownSheetItem extends StatelessWidget {
  final String label;
  final EdgeInsets padding;

  const DropdownSheetItem({
    super.key,
    required this.label,
    this.padding = const EdgeInsets.symmetric(
      vertical: 5,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ListTile(
        tileColor: AppColors.fieldFillColor,
        shape: const RoundedRectangleBorder(
          borderRadius: Corners.rounded10,
        ),
        title: Text(label),
      ),
    );
  }
}
