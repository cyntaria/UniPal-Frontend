import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../../helpers/constants/app_styles.dart';
import '../../../../helpers/constants/app_colors.dart';

// Widgets
import '../../../shared/widgets/custom_textfield.dart';
import '../../providers/teachers_provider.dart';

class SearchBar extends HookConsumerWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                ),
              ),
            ),
          ),

          Insets.gapW10,

          // Search Button
          InkWell(
            onTap: () {
              ref.read(searchFilterProvider.notifier).state =
                  searchController.text;
            },
            child: Container(
              height: 47,
              width: 47,
              decoration: const BoxDecoration(
                gradient: AppColors.buttonGradientPurple,
                borderRadius: Corners.rounded7,
                boxShadow: Shadows.elevated,
              ),
              child: const Icon(
                Icons.search_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
