import 'package:flutter/material.dart';

// Helpers
import '../../../helpers/constants/app_styles.dart';

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
        horizontal: 20,
        vertical: 5,
      ),
      child: ListTile(
        tileColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: Corners.rounded10,
        ),
        title: Text(label),
      ),
    );
  }
}
