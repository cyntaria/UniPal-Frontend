import 'package:flutter/material.dart';

// Helpers
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_styles.dart';

class DropdownSheetItem extends StatelessWidget {
  final String label;

  const DropdownSheetItem({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
      ),
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
