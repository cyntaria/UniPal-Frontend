import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../../providers/teachers_provider.dart';

// Helpers
import '../../../../helpers/constants/app_styles.dart';

// Widgets
import 'teachers_list_item.dart';

class TeachersList extends ConsumerWidget {
  const TeachersList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teachers = ref.watch(
      teachersProvider.select((value) => value.getAllTeachers()),
    );
    final filteredTeachers = ref.watch(searchedTeachersProvider(teachers));
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: filteredTeachers.length,
      separatorBuilder: (_, __) => Insets.gapH15,
      itemBuilder: (_, i) => TeachersListItem(
        teacher: filteredTeachers[i],
      ),
    );
  }
}
