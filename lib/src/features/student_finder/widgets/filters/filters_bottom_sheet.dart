import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_typography.dart';

// Routing
import '../../../../config/routes/app_router.dart';

// Widgets
import '../../../shared/widgets/custom_scrollable_bottom_sheet.dart';
import '../../../shared/widgets/custom_text_button.dart';
import '../../providers/filter_providers.dart';
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
      ..refresh(searchFilteredStudentsProvider);
  }

  void _onSaveTap() {
    ref.refresh(searchFilteredStudentsProvider);
    AppRouter.pop();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollableBottomSheet(
        titleText: 'Filters',
        leading: !hasFilters
            ? null
            : GestureDetector(
                onTap: _onResetTap,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    'Reset',
                    style: AppTypography.primary.body14.copyWith(
                      color: AppColors.textGreyColor,
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
