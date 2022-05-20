import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../../providers/filter_providers.dart';

// Helpers
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_typography.dart';

// Routing
import '../../../../config/routes/app_router.dart';

// Widgets
import '../../../shared/widgets/custom_scrollable_bottom_sheet.dart';
import '../../../shared/widgets/custom_text_button.dart';
import 'filters_list_view.dart';

class FiltersBottomSheet extends ConsumerStatefulWidget {
  const FiltersBottomSheet({super.key});

  @override
  _FiltersBottomSheetState createState() => _FiltersBottomSheetState();
}

class _FiltersBottomSheetState extends ConsumerState<FiltersBottomSheet> {
  bool hasFilters = false;

  void _onResetTap() {
    ref
      ..invalidate(genderFilterProvider)
      ..invalidate(programFilterProvider)
      ..invalidate(campusFilterProvider)
      ..invalidate(hobbyFilterProvider)
      ..invalidate(interestFilterProvider)
      ..invalidate(batchFilterProvider)
      ..invalidate(studentTypeFilterProvider)
      ..invalidate(studentStatusFilterProvider)
      ..invalidate(searchFilterProvider)
      ..refresh(filtersProvider);
    AppRouter.pop();
  }

  void _onSaveTap() {
    ref.refresh(filtersProvider);
    AppRouter.pop();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollableBottomSheet(
        titleText: 'Filters',
        leading: Consumer(
          builder: (_, ref, child) {
            final hasFilters = ref.watch(
              // length 2 because is_active is always present + any additional filters
              filtersProvider.select((value) => value.length >= 2),
            );
            return hasFilters ? child! : const SizedBox.shrink();
          },
          child: GestureDetector(
            onTap: _onResetTap,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                'Reset',
                style: AppTypography.primary.body16.copyWith(
                  color: AppColors.textGreyColor,
                ),
              ),
            ),
          ),
        ),
        trailing: CustomTextButton.gradient(
          width: 60,
          height: 30,
          gradient: AppColors.buttonGradientPurple,
          onPressed: _onSaveTap,
          child: Center(
            child: Text(
              'Apply',
              style: AppTypography.secondary.title18.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
        builder: (_, scrollController) => FiltersListView(
          scrollController: scrollController,
        ),
      ),
    );
  }
}
