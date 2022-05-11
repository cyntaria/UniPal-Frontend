// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';

/// Routing
import '../../../config/routes/app_router.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_typography.dart';

// Widgets
import './custom_text_button.dart';
import './custom_textfield.dart';
import 'custom_scrollable_bottom_sheet.dart';

typedef WidgetBuilder<T> = Widget Function(BuildContext context, T item);
typedef SearchFilter<T> = bool Function(String, T);

/// The sheet used to display all [CustomDropdownItem] for menu item
class CustomDropdownSheet<T> extends StatefulWidget {
  /// This gives the bottom sheet title.
  final String? bottomSheetTitle;

  /// This will give the submit button text.
  final String submitButtonText;

  /// This will give the submit button background color.
  final Color submitButtonColor;

  /// This will give the hint to the search text filed.
  final String? searchHintText;

  /// This will give the background color to the search text filed.
  final Color? searchBackgroundColor;

  /// This callback will decide how to filter items based on search term.
  final SearchFilter<T>? searchFilterCondition;

  /// This will display the search textfield when set to true
  final bool showSearch;

  /// This will give the list of items.
  final List<T> items;

  /// This will give the callback to the selected items (multiple) from list.
  final void Function(List<T>)? onMultipleSelect;

  /// This will give the callback to the selected item (single) from list.
  final void Function(T)? onItemSelect;

  /// This will give selection choise for single or multiple for list.
  final bool enableMultipleSelection;

  /// The callback used to define how each dropdown item will be built.
  final WidgetBuilder<T> itemBuilder;

  /// The padding added around the sheet contents
  final EdgeInsets contentPadding;

  const CustomDropdownSheet({
    Key? key,
    required this.items,
    required this.itemBuilder,
    this.searchFilterCondition,
    this.bottomSheetTitle,
    this.searchHintText,
    this.searchBackgroundColor,
    this.onMultipleSelect,
    this.onItemSelect,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 20),
    String? submitButtonText,
    Color? submitButtonColor,
    bool? enableMultipleSelection,
    this.showSearch = false,
  })  : assert(
          showSearch == false || searchFilterCondition != null,
          'Search must be used with a search condition',
        ),
        this.submitButtonColor = submitButtonColor ?? AppColors.secondaryColor,
        this.submitButtonText = submitButtonText ?? 'DONE',
        this.enableMultipleSelection = enableMultipleSelection ?? false,
        super(key: key);

  const factory CustomDropdownSheet.multiple({
    Key? key,
    required List<T> items,
    required Widget Function(BuildContext, T) itemBuilder,
    bool Function(String, T)? searchFilterCondition,
    String? bottomSheetTitle,
    String? submitButtonText,
    Color? submitButtonColor,
    bool showSearch,
    String? searchHintText,
    Color? searchBackgroundColor,
    void Function(List<T>)? onMultipleSelect,
    void Function(T)? onItemSelect,
  }) = _CustomDropdownSheetWithMultiSelect;

  @override
  State<CustomDropdownSheet> createState() => _CustomDropdownSheetState<T>();
}

class _CustomDropdownSheetState<T> extends State<CustomDropdownSheet<T>> {
  final List<T> _selectedItemList = [];
  late List<T> _filteredItemList;
  late final TextEditingController? searchController;

  @override
  void initState() {
    super.initState();
    _filteredItemList = widget.items;
    if (widget.showSearch) {
      searchController = TextEditingController();
    }
  }

  @override
  void dispose() {
    if (widget.showSearch) {
      searchController?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollableBottomSheet(
      titleText: widget.bottomSheetTitle,
      trailing: !widget.enableMultipleSelection
          ? null
          : Align(
              alignment: Alignment.centerRight,
              child: CustomTextButton(
                color: widget.submitButtonColor,
                width: 50,
                onPressed: () {
                  widget.onMultipleSelect?.call(_selectedItemList);
                  _removeFocusAndPopValue<List<T>>(_selectedItemList);
                },
                child: Center(
                  child: Text(
                    widget.submitButtonText,
                    style: AppTypography.secondary.body14.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
      builder: (_, scrollController) {
        return Padding(
          padding: widget.contentPadding,
          child: Column(
            children: [
              // A [TextField] that displays a list of suggestions as the user types with clear button.
              if (widget.showSearch)
                CustomTextField(
                  controller: searchController,
                  onChanged: (_) => _onSearchChanged(),
                  fillColor: Colors.white,
                  border: const BorderSide(
                    color: AppColors.textLightGreyColor,
                  ),
                  textInputAction: TextInputAction.search,
                  hintText: widget.searchHintText ?? 'Search',
                  hintStyle: const TextStyle(
                    color: AppColors.textLightGreyColor,
                    fontSize: 14,
                  ),
                  prefix: const Icon(Icons.search),
                  suffix: GestureDetector(
                    onTap: _onClearTap,
                    child: const Icon(
                      Icons.cancel,
                      color: Colors.grey,
                    ),
                  ),
                ),

              const SizedBox(height: 10),

              // Item builder
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: _filteredItemList.length,
                  itemBuilder: (context, index) {
                    final item = _filteredItemList[index];

                    return InkWell(
                      onTap: !widget.enableMultipleSelection
                          ? () {
                              widget.onItemSelect?.call(item);
                              _removeFocusAndPopValue<T>(item);
                            }
                          : null,
                      child: widget.itemBuilder(context, item),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// This helps when search enabled & show the filtered data in list.
  void _onSearchChanged() {
    if (searchController == null ||
        searchController!.text.isEmpty ||
        widget.searchFilterCondition == null) {
      _filteredItemList = widget.items;
    } else {
      final fItems = <T>[];

      for (final item in widget.items) {
        final filterItem = widget.searchFilterCondition!.call(
          searchController!.text,
          item,
        );
        if (filterItem) {
          fItems.add(item);
        }
      }
      _filteredItemList = fItems;
    }
    setState(() {});
  }

  /// This helps when want to clear text in search text field.
  void _onClearTap() {
    searchController?.clear();
    setState(() {});
  }

  /// This helps to unfocus the keyboard & pop from the bottom sheet.
  void _removeFocusAndPopValue<R>(R selected) {
    FocusScope.of(context).unfocus();
    AppRouter.pop(selected);
  }
}

class _CustomDropdownSheetWithMultiSelect<T> extends CustomDropdownSheet<T> {
  const _CustomDropdownSheetWithMultiSelect({
    Key? key,
    required List<T> items,
    required WidgetBuilder<T> itemBuilder,
    SearchFilter<T>? searchFilterCondition,
    String? bottomSheetTitle,
    String? submitButtonText,
    Color? submitButtonColor,
    bool showSearch = false,
    String? searchHintText,
    Color? searchBackgroundColor,
    void Function(List<T>)? onMultipleSelect,
    void Function(T)? onItemSelect,
  }) : super(
          key: key,
          items: items,
          enableMultipleSelection: true,
          itemBuilder: itemBuilder,
          searchFilterCondition: searchFilterCondition,
          bottomSheetTitle: bottomSheetTitle,
          submitButtonText: submitButtonText,
          submitButtonColor: submitButtonColor,
          showSearch: showSearch,
          searchHintText: searchHintText,
          searchBackgroundColor: searchBackgroundColor,
          onMultipleSelect: onMultipleSelect,
          onItemSelect: onItemSelect,
        );
}
