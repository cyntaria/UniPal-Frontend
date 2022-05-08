import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../providers/timetables_provider.dart';

// Helpers
import '../../../helpers/constants/app_styles.dart';

// Widgets
import '../widgets/timetables_list/timetable_list_item.dart';

class GeneratedTimetablesScreen extends ConsumerWidget {
  const GeneratedTimetablesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final generatedTimetables = ref.watch(
      timetablesProvider.select((value) => value.generatedTimetables),
    );
    return ListView.separated(
      itemCount: generatedTimetables.length,
      separatorBuilder: (_, __) => Insets.gapH15,
      itemBuilder: (_, i) => TimetableListItem(
        timetableNumber: i,
        timetable: generatedTimetables[i],
      ),
    );
  }
}
