import 'package:flutter/material.dart';

// Widgets
import '../shared/widgets/custom_filter_chip.dart';

class FilterChipsList extends StatefulWidget {
  final List<String> filters;
  final bool Function(String) isSelected;
  final void Function(String) onSelected;

  const FilterChipsList({
    Key? key,
    required this.filters,
    required this.isSelected,
    required this.onSelected,
  }) : super(key: key);

  @override
  _FilterChipsListState createState() => _FilterChipsListState();
}

class _FilterChipsListState extends State<FilterChipsList> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 10,
      spacing: 8,
      children: [
        for (var f in widget.filters)
          CustomFilterChip(
            label: Text(f),
            isSelected: widget.isSelected(f),
            onSelected: (isSelected) {
              if (isSelected) widget.onSelected(f);
            },
          ),
      ],
    );
  }
}
