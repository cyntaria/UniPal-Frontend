import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Helpers
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_styles.dart';

// Widgets
import '../../../shared/widgets/custom_textfield.dart';
import '../filters/filters_bottom_sheet.dart';

class SearchAndFilterBar extends HookWidget {
  const SearchAndFilterBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController(text: '');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search field
          Expanded(
            child: Container(
              height: 47,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: Corners.rounded7,
                boxShadow: Shadows.elevated,
              ),
              child: CustomTextField(
                controller: searchController,
                hintText: 'Search by name',
                hintStyle: const TextStyle(
                  color: AppColors.textLightGreyColor,
                ),
                fillColor: Colors.white,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.search,
                prefix: const Icon(
                  Icons.search_rounded,
                  size: IconSizes.med22,
                  color: AppColors.textLightGreyColor,
                ),
              ),
            ),
          ),

          Insets.gapW10,

          // Filters Button
          InkWell(
            onTap: () {
              showModalBottomSheet<dynamic>(
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                context: context,
                builder: (context) {
                  return const FiltersBottomSheet();
                },
              );
            },
            child: Container(
              height: 47,
              width: 47,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: Corners.rounded7,
                boxShadow: Shadows.elevated,
              ),
              child: const Icon(
                Icons.tune_rounded,
                color: AppColors.textLightGreyColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
