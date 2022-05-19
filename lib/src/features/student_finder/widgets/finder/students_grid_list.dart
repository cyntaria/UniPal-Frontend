import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../../providers/filter_providers.dart';

// Widgets
import '../../../shared/widgets/empty_state_widget.dart';
import '../../../shared/widgets/custom_circular_loader.dart';
import '../../../shared/widgets/error_response_handler.dart';
import 'student_grid_item.dart';

class StudentsGridList extends ConsumerWidget {
  const StudentsGridList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentsFuture = ref.watch(searchFilteredStudentsProvider);
    return SliverToBoxAdapter(
      child: studentsFuture.when(
        loading: () => const CustomCircularLoader(),
        error: (error, st) => ErrorResponseHandler(
          error: error,
          retryCallback: () {},
          stackTrace: st,
        ),
        data: (students) => students.isEmpty
            ? const EmptyStateWidget(
                height: 395,
                width: double.infinity,
                margin: EdgeInsets.only(top: 20),
                title: 'No students found',
                subtitle: 'Try changing the filters or search term.',
              )
            : GridView.builder(
                itemCount: 20,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 4 / 5.5,
                ),
                itemBuilder: (_, i) => const StudentGridItem(
                  student: <String, Object?>{
                    'profile_picture_url':
                        'https://i.pinimg.com/564x/8d/e3/89/8de389c84e919d3577f47118e2627d95.jpg',
                    'first_name': 'Muhammad Rafay',
                    'last_name': 'Siddiqui',
                    'erp': '17855',
                    'graduation_year': 2022,
                    'batch_type': 'senior',
                    'program': 'BSCS',
                    'current_status': 'Looking for lunch buddies',
                  },
                ),
              ),
      ),
    );
  }
}
