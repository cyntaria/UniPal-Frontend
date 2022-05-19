// ignore_for_file: null_check_on_nullable_type_parameter

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart';

// Widgets
import './custom_dropdown_sheet.dart';
import './custom_text_button.dart';

abstract class CustomDropdownField<T> extends StatelessWidget {
  const CustomDropdownField({super.key});

  factory CustomDropdownField.sheet({
    Key? key,
    ValueNotifier<T?>? controller,
    required CustomDropdownSheet<T> itemsSheet,
    required String Function(T) selectedItemText,
    Widget suffixIcon,
    TextStyle selectedStyle,
    Color displayFieldColor,
    String hintText,
    T? initialValue,
  }) = _CustomDropdownFieldSheet;

  const factory CustomDropdownField.animated({
    Key? key,
    String? hintText,
    TextStyle? hintStyle,
    TextStyle? selectedStyle,
    TextStyle? listItemStyle,
    Color fillColor,
    BorderRadius borderRadius,
    bool enableSearch,
    required void Function(T?) onSelected,
    required TextEditingController controller,
    required Map<String, T> items,
  }) = _CustomDropdownFieldAnimated;

  @override
  Widget build(BuildContext context);
}

class _CustomDropdownFieldSheet<T> extends CustomDropdownField<T> {
  /// The notifier used to store and passback selected values to the parent.
  final ValueNotifier<T?> controller;

  /// The icon to display at the end of the field.
  final Widget suffixIcon;

  /// The [TextStyle] used for displaying selected value in the field.
  final TextStyle selectedStyle;

  /// The [Color] used for filling background of the field.
  final Color displayFieldColor;

  /// The initial hint set for the field.
  final String hintText;

  /// The bottom modal sheet used to display dropdown items
  final CustomDropdownSheet<T> itemsSheet;

  /// This callback is used to map the selected value to a
  /// [String] for displaying.
  final String Function(T) selectedItemText;

  /// The initial value to be selected in the dropdown
  final T? initialValue;

  _CustomDropdownFieldSheet({
    super.key,
    ValueNotifier<T?>? controller,
    required this.itemsSheet,
    required this.selectedItemText,
    this.suffixIcon = const Icon(
      Icons.arrow_drop_down_rounded,
      color: AppColors.textGreyColor,
    ),
    this.selectedStyle = const TextStyle(
      fontSize: 16,
      color: AppColors.textGreyColor,
    ),
    this.displayFieldColor = AppColors.fieldFillColor,
    this.hintText = 'Select a value',
    this.initialValue,
  })  : controller = controller ?? ValueNotifier(initialValue);

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
    return CustomTextButton(
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
                style: selectedStyle,
              );
            },
          ),

          // Icon
          suffixIcon,
        ],
      ),
    );
  }
}

class _CustomDropdownFieldAnimated<T> extends CustomDropdownField<T> {
  final String? hintText;
  final TextStyle? hintStyle;
  final TextStyle? selectedStyle;
  final TextStyle? listItemStyle;
  final Color fillColor;
  final BorderRadius borderRadius;
  final void Function(T?) onSelected;
  final TextEditingController controller;
  final Map<String, T> items;
  final bool enableSearch;
  final Widget fieldSuffixIcon;

  const _CustomDropdownFieldAnimated({
    super.key,
    this.hintText,
    this.hintStyle,
    this.listItemStyle,
    this.selectedStyle = const TextStyle(
      fontSize: 16,
      color: AppColors.textGreyColor,
    ),
    this.fieldSuffixIcon = const Icon(
      Icons.keyboard_arrow_down_rounded,
      size: IconSizes.med22,
    ),
    this.fillColor = AppColors.fieldFillColor,
    this.borderRadius = Corners.rounded7,
    this.enableSearch = false,
    required this.onSelected,
    required this.controller,
    required this.items,
  });

  void onChanged(String label) {
    onSelected.call(items[label]);
  }

  @override
  Widget build(BuildContext context) {
    final _items = [hintText ?? 'Select value', ...items.keys];
    return enableSearch
        ? CustomDropdown.search(
            controller: controller,
            items: _items,
            onChanged: onChanged,
            hintText: hintText,
            hintStyle: hintStyle,
            selectedStyle: selectedStyle,
            listItemStyle: listItemStyle,
            borderRadius: borderRadius,
            fillColor: fillColor,
            fieldSuffixIcon: fieldSuffixIcon,
          )
        : CustomDropdown(
            controller: controller,
            items: _items,
            onChanged: onChanged,
            hintText: hintText,
            hintStyle: hintStyle,
            selectedStyle: selectedStyle,
            listItemStyle: listItemStyle,
            borderRadius: borderRadius,
            fillColor: fillColor,
            fieldSuffixIcon: fieldSuffixIcon,
          );
  }
}
