// ignore_for_file: null_check_on_nullable_type_parameter

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart';

// Widgets
import './custom_dropdown_sheet.dart';
import './custom_text_button.dart';

abstract class CustomDropdownField<T> extends StatefulWidget {
  const CustomDropdownField({Key? key}) : super(key: key);

  const factory CustomDropdownField.sheet({
    Key? key,
    ValueNotifier<T?>? controller,
    required CustomDropdownSheet<T> itemsSheet,
    required String Function(T) selectedItemText,
    Widget suffixIcon,
    TextStyle selectedStyle,
    Color displayFieldColor,
    String hintText,
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
    required void Function(T) onSelected,
    required TextEditingController controller,
    required Map<String, T> items,
  }) = _CustomDropdownFieldAnimated;

  @override
  _CustomDropdownFieldState createState();
}

abstract class _CustomDropdownFieldState<T, W extends CustomDropdownField<T>>
    extends State<W> {
  @override
  Widget build(BuildContext context);
}

class _CustomDropdownFieldSheet<T> extends CustomDropdownField<T> {
  /// The notifier used to store and passback selected values to the parent.
  final ValueNotifier<T?>? controller;

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

  const _CustomDropdownFieldSheet({
    Key? key,
    this.controller,
    required this.itemsSheet,
    required this.selectedItemText,
    this.suffixIcon = const Icon(Icons.arrow_drop_down_rounded),
    this.selectedStyle = const TextStyle(
      fontSize: 16,
      color: AppColors.textGreyColor,
    ),
    this.displayFieldColor = AppColors.fieldFillColor,
    this.hintText = 'Select a value',
  }) : super(key: key);

  @override
  _CustomDropdownFieldSheetState createState() =>
      _CustomDropdownFieldSheetState<T>();
}

class _CustomDropdownFieldSheetState<T>
    extends _CustomDropdownFieldState<T, _CustomDropdownFieldSheet<T>> {
  late final ValueNotifier<T?> controller;

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
            return widget.itemsSheet;
          },
        ) ??
        controller.value;
  }

  @override
  void initState() {
    controller = widget.controller ?? ValueNotifier(null);
    super.initState();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      // If we created our own notifier
      controller.dispose(); // then dispose it
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextButton(
      width: double.infinity,
      height: 47,
      onPressed: () => _pickValue(context),
      color: widget.displayFieldColor,
      padding: const EdgeInsets.only(left: 20, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ValueListenableBuilder<T?>(
            valueListenable: controller,
            builder: (_, value, __) {
              var displayValue = widget.hintText;
              if (value != null) {
                displayValue = widget.selectedItemText(value);
              }
              return Text(
                displayValue,
                style: widget.selectedStyle,
              );
            },
          ),

          // Icon
          widget.suffixIcon,
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
  final void Function(T) onSelected;
  final TextEditingController controller;
  final Map<String, T> items;
  final bool enableSearch;

  const _CustomDropdownFieldAnimated({
    Key? key,
    this.hintText,
    this.hintStyle,
    this.listItemStyle,
    this.selectedStyle = const TextStyle(
      fontSize: 16,
      color: AppColors.textGreyColor,
    ),
    this.fillColor = AppColors.fieldFillColor,
    this.borderRadius = Corners.rounded7,
    this.enableSearch = false,
    required this.onSelected,
    required this.controller,
    required this.items,
  }) : super(key: key);

  @override
  _CustomDropdownFieldState createState() =>
      _CustomDropdownFieldAnimatedState<T>();
}

class _CustomDropdownFieldAnimatedState<T>
    extends _CustomDropdownFieldState<T, _CustomDropdownFieldAnimated<T>> {
  void onChanged(String label) {
    widget.onSelected.call(widget.items[label]!);
  }

  @override
  Widget build(BuildContext context) {
    return widget.enableSearch
        ? CustomDropdown.search(
            controller: widget.controller,
            items: widget.items.keys.toList(growable: false),
            onChanged: onChanged,
            hintText: widget.hintText,
            hintStyle: widget.hintStyle,
            selectedStyle: widget.selectedStyle,
            listItemStyle: widget.listItemStyle,
            borderRadius: widget.borderRadius,
            fillColor: widget.fillColor,
            fieldSuffixIcon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: IconSizes.med22,
              color: AppColors.textLightGreyColor,
            ),
          )
        : CustomDropdown(
            controller: widget.controller,
            items: widget.items.keys.toList(growable: false),
            onChanged: onChanged,
            hintText: widget.hintText,
            hintStyle: widget.hintStyle,
            selectedStyle: widget.selectedStyle,
            listItemStyle: widget.listItemStyle,
            borderRadius: widget.borderRadius,
            fillColor: widget.fillColor,
            fieldSuffixIcon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: IconSizes.med22,
              color: AppColors.textLightGreyColor,
            ),
          );
  }
}
