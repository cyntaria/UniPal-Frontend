import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../../../profile/models/student_model.codegen.dart';

// Providers
import '../../providers/filter_providers.dart';

// Widgets
import '../../../shared/widgets/custom_refresh_indicator.dart';
import '../../../shared/widgets/async_value_widget.dart';
import '../../../shared/widgets/empty_state_widget.dart';
import '../../../shared/widgets/custom_circular_loader.dart';
import '../../../shared/widgets/error_response_handler.dart';
import 'student_grid_item.dart';

class StudentsGridList extends ConsumerWidget {
  const StudentsGridList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomRefreshIndicator(
      onRefresh: () async => ref.refresh(filtersProvider),
      displacement: 25,
      child: AsyncValueWidget<List<StudentModel>>(
        value: ref.watch(filteredStudentsProvider),
        loading: () => const Padding(
          padding: EdgeInsets.only(top: 100),
          child: CustomCircularLoader(),
        ),
        error: (error, st) => ErrorResponseHandler(
          error: error,
          retryCallback: () => ref.refresh(filtersProvider),
          stackTrace: st,
        ),
        showEmptyOnNotFoundError: true,
        emptyOrNull: () => const EmptyStateWidget(
          height: 395,
          width: double.infinity,
          margin: EdgeInsets.only(top: 20),
          title: 'No students found',
          subtitle: 'Try changing the filters or search term.',
        ),
        data: (filteredStudents) {
          final students =
              ref.watch(searchedStudentsProvider(filteredStudents));
          return GridView.builder(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: EdgeInsets.zero,
            itemCount: students.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 4 / 5.8,
            ),
            itemBuilder: (_, i) => StudentGridItem(
              student: students[i],
            ),
          );
        },
      ),
    );
  }
}
