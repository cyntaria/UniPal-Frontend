import 'package:flutter/material.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart';
import '../../../helpers/constants/app_typography.dart';

// Widgets
import './custom_dropdown_sheet.dart';
import './custom_text_button.dart';

class CustomDropdownField<T> extends StatelessWidget {
  /// The notifier used to store and passback selected values to the parent.
  final ValueNotifier<T?> controller;

  /// The icon to display at the end of the field.
  final Widget suffixIcon;

  /// The [TextStyle] used for displaying selected value in the field.
  final TextStyle displayTextStyle;

  /// The [Color] used for filling background of the field.
  final Color displayFieldColor;

  /// The initial hint set for the field.
  final String hintText;

  /// The text value used as a label for the field.
  final String floatingText;

  /// The bottom modal sheet used to display dropdown items
  final CustomDropdownSheet<T> itemsSheet;

  /// This callback is used to map the selected value to a
  /// [String] for displaying.
  final String Function(T) selectedItemText;

  const CustomDropdownField({
    Key? key,
    required this.controller,
    required this.itemsSheet,
    required this.selectedItemText,
    this.suffixIcon = const Icon(Icons.arrow_drop_down_rounded),
    this.displayTextStyle = const TextStyle(
      fontSize: 16,
      color: AppColors.textGreyColor,
    ),
    this.displayFieldColor = AppColors.fieldFillColor,
    this.hintText = 'Select a value',
    this.floatingText = 'Dropdown',
  }) : super(key: key);

  Future<void> _pickValue(BuildContext context) async {
    controller.value = await showModalBottomSheet<T?>(
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(15),
            ),
          ),
          context: context,
          builder: (context) {
            return itemsSheet;
          },
        ) ??
        controller.value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            floatingText,
            style: AppTypography.primary.subHeading16.copyWith(
              color: AppColors.textBlackColor,
            ),
          ),
        ),

        Insets.gapH5,

        CustomTextButton(
          width: double.infinity,
          height: 47,
          onPressed: () => _pickValue(context),
          color: displayFieldColor,
          padding: const EdgeInsets.only(left: 20, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ValueListenableBuilder<T?>(
                valueListenable: controller,
                builder: (_, value, __) {
                  var displayValue = hintText;
                  if (value != null) {
                    displayValue = selectedItemText(value);
                  }
                  return Text(
                    displayValue,
                    style: displayTextStyle,
                  );
                },
              ),

              // Icon
              suffixIcon,
            ],
          ),
        ),
      ],
    );
  }
}
