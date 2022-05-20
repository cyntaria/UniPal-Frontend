import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../../helpers/constants/app_colors.dart';

// Providers
import '../../../profile/models/student_model.codegen.dart';
import '../../providers/filter_providers.dart';

// Widgets
import '../../../shared/widgets/async_value_widget.dart';
import '../../../shared/widgets/empty_state_widget.dart';
import '../../../shared/widgets/custom_circular_loader.dart';
import '../../../shared/widgets/error_response_handler.dart';
import 'student_grid_item.dart';

class StudentsGridList extends ConsumerWidget {
  const StudentsGridList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget<List<StudentModel>>(
      value: ref.watch(searchFilteredStudentsProvider),
      loading: () => const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.only(top: 100),
          child: CustomCircularLoader(
            color: AppColors.primaryColor,
          ),
        ),
      ),
      error: (error, st) => SliverToBoxAdapter(
        child: ErrorResponseHandler(
          error: error,
          retryCallback: () {},
          stackTrace: st,
        ),
      ),
      emptyOrNull: () => const SliverToBoxAdapter(
        child: EmptyStateWidget(
          height: 395,
          width: double.infinity,
          margin: EdgeInsets.only(top: 20),
          title: 'No students found',
          subtitle: 'Try changing the filters or search term.',
        ),
      ),
      data: (students) => SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 4 / 5.5,
        ),
        delegate: SliverChildBuilderDelegate(
          childCount: students.length,
          (_, i) => StudentGridItem(
            student: students[i],
          ),
        ),
      ),
    );
  }
}
